class ApplicationController < ActionController::Base
  before_action :read_master_data
  before_action :set_categories

  private

  def read_master_data
    @master_categories = Rails.cache.fetch('master-category-data', expires_in: 6.hours) do
      Category.all.pluck(:id, :code, :name).map { |c| { id: c[0], code: c[1], name: c[2] } }.to_json
    end
    @master_sub_categories = Rails.cache.fetch('master-sub-category-data', expires_in: 6.hours) do
      SubCategory.all.pluck(:code, :name, :category_id).map do |c|
        { code: c[0], name: c[1], category_id: c[2] }
      end.group_by { |c| c[:category_id] }.to_json
    end
    @master_makers = Rails.cache.fetch('master-maker-data', expires_in: 6.hours) do
      Maker.all.pluck(:code, :name).map { |m| { code: m[0], name: m[1] } }.to_json
    end
  end

  # フッターで共通で利用しています
  # 他に良い方法あれば変えたいです。
  # 基本遅延ロードなので、インスタンス変数を使わないアクションではパフォーマンスに影響ないと思います
  def set_categories
    @categories = Category.all
  end
end
