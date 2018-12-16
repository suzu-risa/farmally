# == Schema Information
#
# Table name: makers
#
#  id         :bigint(8)        not null, primary key
#  code       :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Maker < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  def to_param
    code
  end
end
