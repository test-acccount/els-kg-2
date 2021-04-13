class DocumentDetail < ApplicationRecord
  store_accessor :invoice_contacts, :customs_forms_contacts

  validate :single_instance, on: :create

  private
    def single_instance
      errors.add(:count, "1 instance allowed") if DocumentDetail.count == 1
    end
end
