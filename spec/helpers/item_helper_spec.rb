require 'rails_helper'

RSpec.describe ItemHelper, type: :helper do
  include ApplicationHelper

  describe '#maker_price_range' do
    context '小売価格がない場合' do
      let(:item) { create(:item, maker_price: nil, sub_maker_price: nil) }

      it 'ハイフンが表示されること' do
        expect(maker_price_range(item)).to eq '-'
      end
    end

    context '小売価格が単数の場合' do
      let(:item) { create(:item, maker_price: 999, sub_maker_price: nil) }
      let(:item2) do
        create(
          :item,
          category: item.category,
          maker: item.maker,
          maker_price: nil,
          sub_maker_price: 998
        )
      end

      it 'その価格が表示されること' do
        expect(maker_price_range(item)).to eq '999,000'
        expect(maker_price_range(item2)).to eq '998,000'
      end
    end

    context '小売価格が範囲の場合' do
      let(:item) { create(:item, maker_price: 999, sub_maker_price: 998) }
      let(:item2) do
        create(
          :item,
          category: item.category,
          maker: item.maker,
          maker_price: 998,
          sub_maker_price: 999
        )
      end

      it '範囲が表示されること' do
        expect(maker_price_range(item)).to eq '998,000〜999,000'
        expect(maker_price_range(item2)).to eq '998,000〜999,000'
      end
    end
  end
end
