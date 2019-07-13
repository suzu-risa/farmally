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

  SellMakers = [
      {slug: "kubota", title: "クボタ", image: 'https://cosmic-s3.imgix.net/f0d7b150-696d-11e9-bd10-87624fd5798e-kubota.gif'},
      {slug: "yanmar", title: "ヤンマー", image: "https://cosmic-s3.imgix.net/f7ff1310-79f8-11e9-ace3-2b57a47304de-imgsite-logo01.png"},
      {slug: "iseki", title: "イセキiseki", image: "https://cosmic-s3.imgix.net/88c2b4b0-79f9-11e9-a6b7-e5f2fd56d432-iseki.svg"}
  ]

  def to_param
    code
  end
end
