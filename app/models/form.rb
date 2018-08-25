class Form
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :inquiry_type, :string
  attribute :category, :string
  attribute :price, :string
  attribute :name, :string
  attribute :tel, :string
  attribute :address, :string
  attribute :email, :string

  def prettify
    <<~TXT
      *#{inquiry_type}*

      機械の種類: #{category}
      価格: #{price.present? ? price : '未入力'}
      お名前: #{name}
      電話番号: #{tel}
      住所: #{address}
      メールアドレス: #{email.present? ? email : '未入力'}
    TXT
  end
end  
