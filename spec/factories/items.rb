FactoryBot.define do
  factory :item do
    maker_price 10_000
    used_price 8_000
    model 'model'
    horse_power 'horse_power'
    size 'size'
    weight 'weight'
    category
    maker
  end
end
