class IncomingPackage < ApplicationRecord
  include Carrier

  validates :tracking, presence: true, uniqueness: true
end
