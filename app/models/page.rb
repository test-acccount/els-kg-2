class Page < ApplicationRecord
  extend Mobility

  translates :title, type: :string
  translates :content, type: :text

  validates :slug, :title, :content, presence: true
  validates :slug, uniqueness: true
end
