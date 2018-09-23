require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'バリデーションチェック' do
    let (:item) { build(:item, model: 'a' * 256) }

    it '型式名は255文字以内であること' do
      expect(item.valid?).to be_falsey
    end
  end

  describe '#import' do
    before do
      create(:category, name: 'トラクター', code: 'tractor')
      create(:maker, name: 'クボタ', code: 'クボタ')
    end

    context '正常系' do
      it 'インポートできること' do
        file = open(Rails.root.join('db', 'data', 'sample1.csv'))
        result = Item.import(file)
        expect(result[:success]).to be_truthy
        expect(Item.all.size).to eq 3
      end
    end

    context '正常系2' do
      it 'インポートできること' do
        file = open(Rails.root.join('db', 'data', 'sample2.csv'))
        result = Item.import(file)
        expect(result[:success]).to be_truthy
        expect(Item.all.size).to eq 3
      end
    end

    context '異常系' do
      it 'インポートできないこと' do
        file = open(Rails.root.join('db', 'data', 'sample3.csv'))
        result = Item.import(file)
        expect(result[:success]).to be_falsey
      end
    end
  end
end
