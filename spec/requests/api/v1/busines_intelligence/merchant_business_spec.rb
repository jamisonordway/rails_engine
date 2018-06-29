require 'rails_helper'

describe 'merchant business analytics' do
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
  it 'should return customer with most successful transactions for a merchant' do
    merchant = create(:merchant, id: 1)
    customer_1 = create(:customer, id: 1)
    customer_2 = create(:customer, id: 2)

    customer_1_invoice = customer_1.invoices.create(merchant_id: "#{merchant.id}", status: "paid")
    customer_2_invoice = customer_2.invoices.create(merchant_id: "#{merchant.id}", status: "ordered")

    create_list(:transaction, 5, invoice_id: "#{customer_1_invoice.id}", result: "failed")
    create_list(:transaction, 7, invoice_id: "#{customer_2_invoice.id}", result: "success")

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    favorite_customer = JSON.parse(response.body)

    expect(favorite_customer["id"]).to eq(customer_2.id)
  end
end
