class SiteSetting < ApplicationRecord
  store_accessor :data, :site_name, :site_name_short, :domain, :country, :country_code, :contact_phone_numbers

  validate :single_instance, on: :create
  validates :site_name, :site_name_short, :domain, :country, :country_code, :contact_phone_numbers, presence: true

  private
    def single_instance
      errors.add(:count, "1 instance allowed") if SiteSetting.count == 1
    end
end
