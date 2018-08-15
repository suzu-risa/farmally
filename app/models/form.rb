class Form
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :category, :string
  attribute :price, :string
  attribute :name, :string
  attribute :tel, :string
  attribute :address, :string
  attribute :email, :string

  def prettify
    <<~TXT
      *農機具選びの無料相談依頼*

      カテゴリー: #{category}
      価格: #{price}
      お名前: #{name}
      電話番号: #{tel}
      住所: #{address}
      メールアドレス: #{email || '未入力'}
    TXT
  end
end  
