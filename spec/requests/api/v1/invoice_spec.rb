require 'rails_helper'

describe "Invoices Record" do
    it "sends a list of invoices" do
        create_list(:invoice, 3)

        get '/api/v1/invoices'

        expect(response).to be_successful

        invoices = JSON.parse(response.body)
    end 
    it "can get one invoice by its id" do
        id = create(:invoice).id

        get "/api/v1/invoices/#{id}"

        invoice = JSON.parse(response.body)
        expect(response).to be_successful
        expect(invoice["id"]).to eq(id)
    end 
    it "can create a new invoice" do
        id = create(:invoice).id
        invoice_params = { customer_id: 1, merchant_id: 1, status: "paid"}

        post "/api/v1/invoices", params: {invoice: invoice_params}
        invoice = Invoice.last

        assert_response :success
        expect(response).to be_successful

        expect(invoice.status).to eq(invoice_params[:status])
    end 
    it "can update an existing invoice" do
        id = create(:invoice).id
        previous_status = Invoice.last.status
        invoice_params = { status: "Shipped" }

        put "/api/v1/invoices/#{id}", params: {invoice: invoice_params}
        invoice = Invoice.find_by(id: id)
        
        expect(response).to be_successful
        expect(invoice.status).to_not eq(previous_status)
        expect(invoice.status).to eq("Shipped")
    end 
    it "can destroy an invoice" do
        invoice = create(:invoice)

        expect(Invoice.count).to eq(1)
        
        delete "/api/v1/invoices/#{invoice.id}"

        expect(response).to be_successful
        expect(Invoice.count).to eq(0)
        expect{Invoice.find(invoice.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end 
end 