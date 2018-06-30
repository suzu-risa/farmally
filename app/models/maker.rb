class Maker < ApplicationRecord
  has_many :items

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end
