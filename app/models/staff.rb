# == Schema Information
#
# Table name: staffs
#
#  id           :bigint(8)        not null, primary key
#  description  :text(65535)
#  name         :string(255)
#  phone_number :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Staff < ApplicationRecord
  has_many :sale_items

  has_one_attached :picture
end
