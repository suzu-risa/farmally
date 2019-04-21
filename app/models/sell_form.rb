class SellForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :category, :string
  attribute :maker, :string
  attribute :name, :string
  attribute :tel, :string
  attribute :prefecture, :string
  attribute :message, :string
  attribute :lp_pattern, :string

  def prettify
    <<~TXT
      種類: #{category}
      メーカー: #{maker}
      お名前: #{name}
      電話番号: #{tel}
      お住まいの都道府県: #{prefecture}
      ご要望・お問い合わせ：#{message}
      LPパターン: #{lp_pattern}
    TXT
  end
end
