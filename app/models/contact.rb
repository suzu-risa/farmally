# == Schema Information
#
# Table name: contacts
#
#  id           :bigint(8)        not null, primary key
#  category     :integer          default(0), not null
#  contents     :text(65535)
#  email        :string(255)      not null
#  phone_number :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Contact < ApplicationRecord
end
