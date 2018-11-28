class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :sub_categories, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  def to_param
    code
  end
end
