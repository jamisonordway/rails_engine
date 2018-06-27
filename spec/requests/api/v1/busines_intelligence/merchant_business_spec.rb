require 'rails_helper'

describe 'merchant with most items sold' do
  it 'should return merchant with most items' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_3)

    create(:transaction, invoice: invoice_1, result: "success")
    create(:transaction, invoice: invoice_2, result: "success")
    create(:transaction, invoice: invoice_3, result: "failed")

    create(:invoice_item, invoice: invoice_1, unit_price: 100, quantity: 100)
    create(:invoice_item, invoice: invoice_2, unit_price: 100, quantity: 1345)
    create(:invoice_item, invoice: invoice_3, unit_price: 1234, quantity: 2000)

    get "/api/v1/merchants/most_items?quantity=1"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)

    expect(merchants.first.id).to eq(merchant_2.id)
  end
end
