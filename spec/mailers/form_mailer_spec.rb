require "rails_helper"

RSpec.describe FormMailer, type: :mailer do
  describe "send_mail" do
    let(:mail) { FormMailer.send_mail }

    it "renders the headers" do
      expect(mail.subject).to eq("Send mail")
      expect(mail.to).to eq(["yosuke.saito1202@gmail.com"])
      expect(mail.from).to eq(["no-reply@farmally.jp"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
