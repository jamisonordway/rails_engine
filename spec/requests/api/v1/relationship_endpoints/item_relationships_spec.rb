require 'rails_helper'

describe "Items API" do
  describe "relationships" do
    it "can return merchant associated with an item" do
     merchant_1 = create(:merchant)
     merchant_2 = create(:merchant)
     merchant_3 = create(:merchant)
     item_1 = create(:item, merchant: merchant_1)
     item_2 = create(:item, merchant: merchant_2)
     item_3 = create(:item, merchant: merchant_3)

     get "/api/v1/items/#{item_2.id}/merchant"

     merchant = JSON.parse(response.body)

     expect(response).to be_successful
     expect(merchant["id"]).to eq(merchant_2.id)
    end 
    it "can return invoice_items associated with an item" do
      items = create_list(:item, 5)
      15.times do
        create(:invoice_item, item: items.sample)
      end 

      get "/api/v1/items/#{items[3].id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(items[3].invoice_items.count).to eq(invoice_items.count)
    end 
  end 
end 