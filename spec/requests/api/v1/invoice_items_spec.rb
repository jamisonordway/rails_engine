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