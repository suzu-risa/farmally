class BuyForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :item_id, :integer
  attribute :name, :string
  attribute :tel, :string
  attribute :postal_code, :string
  attribute :address, :string
  attribute :email, :string
  attribute :message, :string
  attribute :recieve_contact, :string

  def prettify
    <<~TXT
      ItemID: #{item_id}
      お名前: #{name}
      電話番号: #{tel}
      郵便番号: #{postal_code}
      住所: #{address}
      メールアドレス: #{email}
      問い合わせ内容：#{message}
      入荷・価格変更時に連絡を受け付ける: #{recieve_contact}
    TXT
  end
end
