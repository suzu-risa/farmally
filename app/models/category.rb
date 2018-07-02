class Category < ApplicationRecord
  has_many :items

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  def to_param
    category_code
  end
end
