class User < ApplicationRecord
  include PgSearch

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :lockable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :passport, dependent: :destroy
  has_many :packages, dependent: :destroy
  has_many :shipments, through: :packages

  pg_search_scope :search_by_name_and_email,
    against: { email: "C" },
    associated_against: {
      passport: { first_name: "B", last_name: "A" }
    },
    using: {
      tsearch: { prefix: true }
    }

  validates :locale, inclusion: I18n.available_locales.map(&:to_s)

  def self.from_omniauth(auth, selected_locale)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.locale = selected_locale if user.locale.nil?
    end
  end

  # Auto remember user on Login
  def remember_me
    true
  end
end
