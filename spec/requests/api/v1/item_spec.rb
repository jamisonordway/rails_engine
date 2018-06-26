require 'rails_helper'

describe "Items Record Endpoints" do
    it "sends a list of items" do
        create_list(:item, 3)

        get '/api/v1/items'

        expect(response).to be_successful

        items = JSON.parse(response.body)
    end 
    it "can send one item" do
        id = create(:item).id

        get "/api/v1/items/#{id}"

        item = JSON.parse(response.body)
        expect(response).to be_successful
        expect(item["id"]).to eq(id)
    end 
    it "can find first instance by name" do
        name = create_list(:item, 3).first.name
        
        get "/api/v1/items/find?name=#{name}"

        expect(response).to be_successful

        item = JSON.parse(response.body)

        expect(item["name"]).to eq(name)
    end 
    it "can find first instance by description" do
        description = create_list(:item, 3).first.description
        
        get "/api/v1/items/find?description=#{description}"

        expect(response).to be_successful

        item = JSON.parse(response.body)
        
        expect(item["description"]).to eq(description)
    end 
    it "can find first instance by unit price" do
        item = create_list(:item, 3).first

        get "/api/v1/items/find?unit_price=#{item.unit_price}"

        expect(response).to be_successful

        result = JSON.parse(response.body)

        expect(result["id"]).to eq(item.id)
    end 
    it "can find first instance by merchant" do
        merchant_id = create_list(:item, 3).first.merchant_id
        
        get "/api/v1/items/find?merchant_id=#{merchant_id}"

        expect(response).to be_successful

        item = JSON.parse(response.body)

        expect(item["merchant_id"]).to eq(merchant_id)
    end
    it "can get all items by matching name" do
        item = create_list(:item, 3).first
        

        get "/api/v1/items/find_all?name=#{item.name}"

        items = JSON.parse(response.body)
        expect(response).to be_successful
        
        expect(item["name"]).to eq(item.name)
        expect(items.count).to eq(3)
    end 
    it "can get all items by matching description" do
        item = create_list(:item, 3).first

        get "/api/v1/items/find_all?description=#{item.description}"

        items = JSON.parse(response.body)

        expect(response).to be_successful
        
        expect(items.first["description"]).to eq(item.description)
        expect(items.count).to eq(3)
    end 
    it "can get all items by matching unit price" do
        item = create_list(:item, 3).first
  
        get "/api/v1/items/find_all?unit_price=#{item.unit_price}"
  
        items = JSON.parse(response.body)
  
        expect(response).to be_successful
        expect(items.count).to eq(3)
    end  
    it "can get all items by matching merchant_id" do
        item = create_list(:item, 3).first
  
        get "/api/v1/items/find_all?merchant_id=#{item.merchant_id}"
  
        items = JSON.parse(response.body)
  
        expect(response).to be_successful
        expect(items.first["merchant_id"]).to eq(item.merchant_id)
        expect(items.count).to eq(1)
      end
      it "can return single item by created_at param" do
        create(:item)
        id = Item.last.id
        created_at = Item.last.created_at
    
        get "/api/v1/items/find?created_at=#{created_at}"
    
        item = JSON.parse(response.body)
    
        expect(response).to be_success
        expect(item["id"]).to eq(id)
      end
    
      it "can return single item by updated_at param" do
        create(:item)
        id = Item.last.id
        updated_at = Item.last.updated_at
    
        get "/api/v1/items/find?updated_at=#{updated_at}"
    
        item = JSON.parse(response.body)
    
        expect(response).to be_success
        expect(item["id"]).to eq(id)
      end
      it "can return all items by created at param" do
        create(:item)
        create_list(:item, 3, created_at: "2018-04-31 12:12:12 UTC")
        created_at = Item.last.created_at
    
        get "/api/v1/items/find_all?created_at=#{created_at}"
    
        items = JSON.parse(response.body)
    
        expect(response).to be_success
        expect(items.count).to eq(3)
      end 
      it "can return all items by updated at param" do
        create(:item)
        create_list(:item, 3, updated_at: "2018-04-31 11:11:11 UTC")
        updated_at = Item.last.updated_at
    
        get "/api/v1/items/find_all?updated_at=#{updated_at}"
    
        items = JSON.parse(response.body)
    
        expect(response).to be_success
        expect(items.count).to eq(3)
      end 
      it 'can return a random item' do
        items = create_list(:item, 5)
    
        get '/api/v1/items/random'
    
        item = JSON.parse(response.body)
    
        expect(response).to be_success
    
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
        previous_name = Item.last.name
        item_params = { name: "Okay Item" }

        put "/api/v1/items/#{id}", params: {item: item_params}
        item = Item.find_by(id: id)
        
        expect(response).to be_successful
        expect(item.name).to_not eq(previous_name)
        expect(item.name).to eq("Okay Item")
    end 
    it "can destroy an item" do
        item = create(:item)

        expect(Item.count).to eq(1)
        
        delete "/api/v1/items/#{item.id}"

        expect(response).to be_successful
        expect(Item.count).to eq(0)
        expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end 
end 