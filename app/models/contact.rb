# == Schema Information
#
# Table name: contacts
#
#  id           :bigint(8)        not null, primary key
#  category     :integer          default(0), not null
#  contents     :text(65535)
#  name         :string(255)      not null
#  phone_number :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Contact < ApplicationRecord
  enum category: { buy: 0, sell: 1, other: 2 }

  def prettify
    <<~TXT
      *お問い合わせフォームからのお問い合わせ*

      #{self.class.human_attribute_name(:name)}: #{name}
      #{self.class.human_attribute_name(:phone_number)}: #{phone_number}
      #{self.class.human_attribute_name(:category)}: #{category_i18n}
      #{self.class.human_attribute_name(:contents)}: #{contents? ? contents : '記入なし'}
    TXT
  end
end
