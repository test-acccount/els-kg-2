class SitePricing < ApplicationRecord
  store_accessor :data, :shipping_local, :shipping_usd

  validate :single_instance, on: :create
  validates :shipping_local, :shipping_usd, presence: true

  private
    def single_instance
      errors.add(:count, "1 instance allowed") if SitePricing.count == 1
    end
end
