require 'rails_helper'

describe 'merchant business analytics' do

  it 'returns the total revenue for that merchant across successful transactions' do
    merchant = create(:merchant)
    invoice_list = create_list(:invoice, 3, merchant: merchant)
    create(:transaction, invoice: invoice_list[0], result: "Success")
    create(:transaction, invoice: invoice_list[1], result: "Success")
    create(:transaction, invoice: invoice_list[2], result: "Failed")
    create(:invoice_item, invoice: invoice_list[0], unit_price: 100, quantity: 100)
    create(:invoice_item, invoice: invoice_list[1], unit_price: 100, quantity: 100)
    create(:invoice_item, invoice: invoice_list[2], unit_price: 1234, quantity: 1345)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success
    # revenue = JSON.parse([response.body].to_json).first
    # expect(revenue).to eq(2000)
  end
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
    create(:invoice_item, invoice: invoice_2, unit_price: 10, quantity: 100)
    create(:invoice_item, invoice: invoice_3, unit_price: 1, quantity: 2000)

    get "/api/v1/merchants/most_items?quantity=1"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants.first["id"]).to eq(merchant_1.id)
    expect(merchants.first["name"]).to eq(merchant_1.name)
  end

  it 'should return merchant with the most revenue' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)
    invoice_3 = create(:invoice, merchant: merchant_3)

    create(:transaction, invoice: invoice_1, result: "success")
    create(:transaction, invoice: invoice_2, result: "success")
    create(:transaction, invoice: invoice_3, result: "failed")

    create(:invoice_item, invoice: invoice_1, unit_price: 1, quantity: 100)
    create(:invoice_item, invoice: invoice_2, unit_price: 100, quantity: 100)
    create(:invoice_item, invoice: invoice_3, unit_price: 100, quantity: 2000)

    get '/api/v1/merchants/most_revenue?quantity=1'

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants.first["id"]).to eq(merchant_2.id)
    expect(merchants.first["name"]).to eq(merchant_2.name)
  end
end
