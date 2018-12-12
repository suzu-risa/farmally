require 'rails_helper'

RSpec.describe SaleItemDecorator do
  let(:sale_item) { SaleItem.new.extend SaleItemDecorator }
  subject { sale_item }
  it { should be_a SaleItem }
end
