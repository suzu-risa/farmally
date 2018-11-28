require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'バリデーションチェック' do
    let(:category) { create(:category) }
    let(:sub_category) { create(:sub_category, category: category) }
    let (:item) { build(:item, model: 'a' * 256, category: category, sub_category: sub_category) }

    it '型式名は255文字以内であること' do
      expect(item.valid?).to be_falsey
    end
  end

  describe '#import' do
    before do
      category = create(:category, name: 'トラクター', code: 'tractor')
      category2 = create(:category, name: '原動機', code: 'gendoki')
      create(:maker, name: 'クボタ', code: 'クボタ')
      create(:sub_category, name: '歩行用トラクター', code: 'tractor-for-walk', category: category)
      create(:sub_category, name: '乗用トラクター（半装軌型）', code: 'tractor-for-ride', category: category)
      create(:sub_category, name: '傾斜草地用多機能トラクター', code: 'multi-feature-tractor', category: category)
      create(:sub_category, name: '空冷ガソリンエンジン', code: 'air-cooled_gasoline_engine', category: category2)
    end

    context '正常系' do
      context '価格にカンマが含まれない場合' do
        it 'インポートできること' do
          file = open(Rails.root.join('db', 'test_data', 'sample1.csv'))
          result = Item.import(file)
          expect(result[:success]).to be_truthy
          expect(Item.all.size).to eq 3
        end
      end

      context '' do
        it '価格にカンマが含まれる場合' do
          file = open(Rails.root.join('db', 'test_data', 'sample2.csv'))
          result = Item.import(file)
          expect(result[:success]).to be_truthy
          expect(Item.all.size).to eq 3
        end
      end

      context '価格が範囲指定されている場合' do
        it '範囲でインポートできること' do
          file = open(Rails.root.join('db', 'test_data', 'sample3.csv'))
          result = Item.import(file)
          expect(result[:success]).to be_truthy
          expect(Item.find_by(maker_price: 433).sub_maker_price).to eq 432
          expect(Item.find_by(maker_price: 366).sub_maker_price).to eq 367
          expect(Item.find_by(maker_price: 866).sub_maker_price).to be_nil
        end
      end
    end

    context '異常系' do
      context 'サブカテゴリーがない場合' do
        it 'インポートできないこと' do
          file = open(Rails.root.join('db', 'test_data', 'sample4.csv'))
          result = Item.import(file)
          expect(result[:success]).to be_falsey
        end
      end

      context 'カテゴリーとサブカテゴリーが一致しない場合' do
        it 'インポートできないこと' do
          file = open(Rails.root.join('db', 'test_data', 'sample5.csv'))
          result = Item.import(file)
          expect(result[:success]).to be_falsey
        end
      end
    end
  end
end
