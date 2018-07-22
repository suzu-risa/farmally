require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'バリデーションチェック' do
    let (:item) { build(:item, model: 'a' * 256) }

    it '型式名は255文字以内であること' do
      expect(item.valid?).to be_falsey
    end
  end
end
