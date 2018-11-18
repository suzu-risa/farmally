FactoryBot.define do
  factory :sale_property, class: 'Sale::Property' do
    sale_property_template nil
    name "MyString"
  end
end
