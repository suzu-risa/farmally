class InquiryForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :tel, :string
  attribute :email, :string
  attribute :message, :string
  attribute :request_notification, :string
  attribute :agree_to_terms, :string

  def prettify
    <<~TXT
      お名前: #{name}
      電話番号: #{tel}
      メールアドレス: #{email}
      問い合わせ内容: #{message}
      価格変更連絡・入荷連絡：#{request_notification}
      利用規約に同意する: #{agree_to_terms}
    TXT
  end
end