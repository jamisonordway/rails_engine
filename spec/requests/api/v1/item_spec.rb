require 'rails_helper'

describe "Items Record" do
    it "sends a list of items" do
        create_list(:item, 3)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body)
    end 
    it "can get one item by its id" do
        id = create(:item).id

        get "/api/v1/items/#{id}"

        item = JSON.parse(response.body)
        expect(response).to be_successful
        expect(item["id"]).to eq(id)
    end 
    it "can create a new item" do
        id = create(:item).id
        item_params = { name: "Cool Item", description: "Best description ever", unit_price: 1, merchant_id: 1}

        post "/api/v1/items", params: {item: item_params}
        item = Item.last

        assert_response :success
        expect(response).to be_successful

        expect(item.name).to eq(item_params[:name])
    end 
    it "can update an existing item" do
        id = create(:item).id
        previous_status = item.last.name
        item_params = { name: "Okay Item" }

        put "/api/v1/items/#{id}", params: {item: item_params}
        item = Item.find_by(id: id)
        
        expect(response).to be_successful
        expect(item.name).to_not eq(previous_name)
        expect(item.name).to eq("Okay Item")
    end 
    it "can destroy an item" do
        item = create(:item)

        expect(item.count).to eq(1)
        
        delete "/api/v1/items/#{item.id}"

        expect(response).to be_successful
        expect(item.count).to eq(0)
        expect{item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end 
end 