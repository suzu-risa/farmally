class Maker < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :code, presence: true
end
