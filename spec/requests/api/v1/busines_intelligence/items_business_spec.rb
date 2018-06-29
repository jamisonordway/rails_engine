require 'rails_helper'

describe 'items business analytics' do
  it 'returns the top x items ranked by total revenue generated' do
    item_1 = create(:item, id: 4)
    item_2 = create(:item, id: 5)

    merchant = create(:merchant)
    customer = create(:customer)

    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, status: "status")

    create_list(:invoice_item, 5, quantity: 5, unit_price: 5, invoice_id: invoice.id, item_id: item_1.id)
    create_list(:invoice_item, 4, quantity: 5, unit_price: 5, invoice_id: invoice.id, item_id: item_2.id)

    get '/api/v1/items/most_revenue?quantity=2'

    items = JSON.parse(response.body)

    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item_1.id)
    expect(items.first["name"]).to eq(item_1.name)
    expect(items.last["id"]).to eq(item_2.id)
    expect(items.last["name"]).to eq(item_2.name)
  end

  it 'returns the top x item instances ranked by total number sold' do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice)

    create(:invoice_item, invoice: invoice1, item: item_1, unit_price: 100, quantity: 5)
    create(:invoice_item, invoice: invoice2, item: item_2, unit_price: 100, quantity: 1)

    create(:transaction, invoice: invoice1, result: "Success")
    create(:transaction, invoice: invoice2, result: "Success")

    expected = [{"id"=>item_1.id,
      "name"=>item_1.name,
      "description"=>item_1.description,
      "merchant_id"=>item_1.merchant_id,
      "unit_price"=>item_1.unit_price.to_s}]

    get "/api/v1/items/most_items?quantity=1"

    item = JSON.parse(response.body)

    expect(item).to eq(expected)
  end
end
