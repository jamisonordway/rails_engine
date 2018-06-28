require 'rails_helper'

describe 'customer business analytics' do
  it 'returns a merchant where the customer has conducted the most successful transactions' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
    create(:transaction, result: "success", invoice: invoice_1)
    create(:transaction, result: "success", invoice: invoice_1)
    create(:transaction, result: "failed", invoice: invoice_2)
    create(:transaction, result: "success", invoice: invoice_2)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"
    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(merchant_1.id)
  end
end
