class BuyForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  validates :name, presence: true
  validates :tel, presence: true
  validates :address, presence: true
  validates :email, presence: true
  validates :agree_to_terms, acceptance: true

  attribute :item_id, :integer
  attribute :name, :string
  attribute :tel, :string
  attribute :address, :string
  attribute :email, :string
  attribute :message, :string
  attribute :agree_to_terms, :string

  def prettify
    <<~TXT
      商品ID: #{item_id}
      お名前: #{name}
      電話番号: #{tel}
      住所: #{address}
      メールアドレス: #{email}
      問い合わせ内容：#{message}
      利用規約に同意する: #{agree_to_terms}
    TXT
  end
end
