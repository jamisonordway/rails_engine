require 'rails_helper'

describe "Invoice Items Record" do
    it "sends a list of invoice items" do
        create_list(:invoice_item, 3)

        get "/api/v1/invoice_items"

        expect(response).to be_successful

        invoice_items = JSON.parse(response.body)
    end 
    it "can get one invoice item by its id" do
        id = create(:invoice_item).id

        get "/api/v1/invoice_items/#{id}"

        invoice_item = JSON.parse(response.body)
        expect(response).to be_successful
        expect(invoice_item["id"]).to eq(id)
    end
    it "can find first invoice item by item id" do
        item_id = create_list(:invoice_item, 3).first.item_id

        get "/api/v1/invoice_items/find?item_id=#{item_id}"

        expect(response).to be_successful

        invoice_item = JSON.parse(response.body)
        
        expect(invoice_item["item_id"]).to eq(item_id)
    end 
    it "can find first invoice item by invoice id" do
        invoice_id = create_list(:invoice_item, 3).first.invoice_id

        get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

        expect(response).to be_successful

        invoice_item = JSON.parse(response.body)
        
        expect(invoice_item["invoice_id"]).to eq(invoice_id)
    end 
    it "can find first invoice item by quantity" do
        quantity = create(:invoice_item).quantity

        get "/api/v1/invoice_items/find?quantity=#{quantity}"

        expect(response).to be_successful

        invoice_item = JSON.parse(response.body)

        expect(invoice_item["quantity"]).to eq(quantity)
    end 
    it "can find first invoice item by created_at" do
        create(:invoice_item, created_at: "2018-04-31 12:12:12 UTC")
        id = InvoiceItem.last.id
        created_at = InvoiceItem.last.created_at

        get "/api/v1/invoice_items/find?created_at=#{created_at}"

        invoice_item = JSON.parse(response.body)

        expect(invoice_item["id"]).to eq(id)
    end 
    it "can find first invoice item by updated_at" do
        create(:invoice_item, updated_at: "2018-04-31 12:12:12 UTC")
        id = InvoiceItem.last.id
        updated_at = InvoiceItem.last.updated_at

        get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

        invoice_item = JSON.parse(response.body)

        expect(response).to be_successful
        expect(invoice_item["id"]).to eq(id)
    end 
    it "can find first invoice item by unit_price" do
        create(:invoice_item, unit_price: 1000)
        unit_price = InvoiceItem.last.unit_price

        get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

        invoice_item = JSON.parse(response.body)

        expect(response).to be_successful
        expect(invoice_item["unit_price"]).to eq(unit_price)
    end 
    it "can find all invoice items by item id" do
        item_id = create_list(:invoice_item, 3).first.item_id

        get "/api/v1/invoice_items/find_all?item_id=#{item_id}"

        expect(response).to be_successful

        invoice_items = JSON.parse(response.body)
        
        expect(invoice_items.first["item_id"]).to eq(item_id)
    end 
    it "can find all invoice items by invoice id" do
        invoice_id = create_list(:invoice_item, 3).first.invoice_id

        get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_id}"

        expect(response).to be_successful

        invoice_items = JSON.parse(response.body)

        expect(invoice_items.count).to eq(1)
    end 
    it "can find all invoice items by quantity" do
        create_list(:invoice_item, 3, quantity: 2)
        quantity = InvoiceItem.last.quantity

        get "/api/v1/invoice_items/find_all?quantity=#{quantity}"

        invoice_items = JSON.parse(response.body)

        expect(response).to be_successful

        expect(invoice_items.first["quantity"]).to eq(quantity)
        expect(invoice_items.count).to eq(3)
    end 
    it "can find all invoice items by created_at" do
        create_list(:invoice_item, 3, created_at: "2018-04-31 12:12:12 UTC")
        created_at = InvoiceItem.last.created_at

        get "/api/v1/invoice_items/find_all?created_at=#{created_at}"

        invoice_items = JSON.parse(response.body)
        
        expect(response).to be_successful
        expect(invoice_items.count).to eq(3)
    end 
    it "can find all invoice items by updated_at" do
        create_list(:invoice_item, 3, updated_at: "2018-05-31 12:12:12 UTC")
        updated_at = InvoiceItem.last.updated_at

        get "/api/v1/invoice_items/find_all?updated_at=#{updated_at}"

        invoice_items = JSON.parse(response.body)

        expect(response).to be_successful
        expect(invoice_items.count).to eq(3)
    end 
    it "can find all invoice items by unit_price" do
        create_list(:invoice_item, 3, unit_price: 1000)
        unit_price = InvoiceItem.last.unit_price

        get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"

        invoice_items = JSON.parse(response.body)

        expect(response).to be_successful
        expect(invoice_items.count).to eq(3)
    end 
    it "can return a random invoice item" do
        invoice_items = create_list(:invoice_item, 5)

        get "/api/v1/invoice_items/random"

        invoice_item = JSON.parse(response.body)

        expect(response).to be_successful
    end 
    it "can create a new invoice item" do
        id = create(:invoice_item).id
        invoice_item_params = { item_id: 1, invoice_id: 1, quantity: 1 }

        post "/api/v1/invoice_items", params: {invoice_item: invoice_item_params}
        invoice_item = InvoiceItem.last
        
        assert_response :success
        expect(response).to be_successful
        
        expect(invoice_item.quantity).to eq(invoice_item_params[:quantity])
    end
    it "can update an existing invoice item" do
        id = create(:invoice_item).id 
        previous_price = InvoiceItem.last.quantity
        invoice_item_params = { quantity: 2 }

        put "/api/v1/invoice_items/#{id}", params: { invoice_item: invoice_item_params }
        invoice_item = InvoiceItem.find_by(id: id)

        expect(response).to be_successful
        expect(invoice_item.quantity).to_not eq(previous_price)
        expect(invoice_item.quantity).to eq(2)
    end 
    it "can destroy an invoice item" do
        invoice_item = create(:invoice_item)
        
        expect(InvoiceItem.count).to eq(1)
        
        delete "/api/v1/invoice_items/#{invoice_item.id}"

        expect(response).to be_successful
        expect(InvoiceItem.count).to eq(0)
        expect{InvoiceItem.find(invoice_item.id)}.to raise_error(ActiveRecord::RecordNotFound)
     end
end 