require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /search' do
    before do
      @category = create(:category)
      category2 = create(:category, name: 'cat2', code: 'cat2')
      @sub_category = create(:sub_category, category: @category)
      sub_category2 = create(:sub_category, name: 'sub_cat2', code: 'sub_cat2', category: category2)
      sub_category3 = create(:sub_category, name: 'sub_cat3', code: 'sub_cat3', category: @category)
      @maker = create(:maker)
      maker2 = create(:maker, name: 'maker2', code: 'maker2')
      create(:item, model: 'item1', category: @category, sub_category: @sub_category, maker: @maker)
      create(:item, model: 'item2', category: @category, sub_category: sub_category3, maker: maker2)
      create(:item, model: 'item3', category: category2, sub_category: sub_category2, maker: @maker)
      create(:item, model: 'item4', category: category2, sub_category: sub_category2, maker: maker2)
    end

    context '検索条件がカテゴリーのみの場合' do
      it '正しい検索結果を得られること' do
        get search_path, params: { search_item_form: { category: @category.code } }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'item1'
        expect(response.body).to include 'item2'
        expect(response.body).not_to include 'item3'
        expect(response.body).not_to include 'item4'
      end
    end

    context '検索条件がメーカーのみの場合' do
      it '正しい検索結果を得られること' do
        get search_path, params: { search_item_form: { maker: @maker.code } }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'item1'
        expect(response.body).not_to include 'item2'
        expect(response.body).to include 'item3'
        expect(response.body).not_to include 'item4'
      end
    end

    context '検索条件がカテゴリーとサブカテゴリーの場合' do
      it '正しい検索結果を得られること' do
        get search_path, params: { search_item_form: { category: @category.code, sub_category: @sub_category.code } }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'item1'
        expect(response.body).not_to include 'item2'
        expect(response.body).not_to include 'item3'
        expect(response.body).not_to include 'item4'
      end
    end

    context '検索条件がカテゴリーとメーカーの場合' do
      it '正しい検索結果を得られること' do
        get search_path, params: { search_item_form: { category: @category.code, maker: @maker.code } }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'item1'
        expect(response.body).not_to include 'item2'
        expect(response.body).not_to include 'item3'
        expect(response.body).not_to include 'item4'
      end
    end

    context '検索条件が全て指定されている場合' do
      it '正しい検索結果を得られること' do
        get search_path, params: { search_item_form: { category: @category.code, sub_category: @sub_category.code, maker: @maker.code } }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'item1'
        expect(response.body).not_to include 'item2'
        expect(response.body).not_to include 'item3'
        expect(response.body).not_to include 'item4'
      end
    end

    context '検索条件がない場合' do
      it '正しい検索結果を得られること' do
        get search_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include 'item1'
        expect(response.body).to include 'item2'
        expect(response.body).to include 'item3'
        expect(response.body).to include 'item4'
      end
    end
  end
end
