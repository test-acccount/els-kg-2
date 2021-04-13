class Passport < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  validates :first_name, :last_name, :phone, :address_line,
            :address_city, :address_zipcode, presence: true
  validates :photos, presence: true
end
