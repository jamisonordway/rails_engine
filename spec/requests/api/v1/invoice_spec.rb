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
    it "can find first invoice by customer id" do
        customer_id = create_list(:invoice, 3).first.customer_id

        get "/api/v1/invoices/find?customer_id=#{customer_id}"

        expect(response).to be_successful

        invoice = JSON.parse(response.body)

        expect(invoice["customer_id"]).to eq(customer_id)
    end 
    it "can find first invoice by merchant id " do
        merchant_id = create_list(:invoice, 3).first.merchant_id

        get "/api/v1/invoices/find?merchant_id=#{merchant_id}"

        expect(response).to be_successful

        invoice = JSON.parse(response.body)

        expect(invoice["merchant_id"]).to eq(merchant_id)
    end 
    it "can find first invoice by status" do 
        status = create_list(:invoice, 3).first.status

        get "/api/v1/invoices/find?status=#{status}"

        invoice = JSON.parse(response.body)

        expect(invoice["status"]).to eq(status)
    end 
    it "can find first invoice by created at" do
        create(:invoice, created_at: "2018-04-31 12:12:12 UTC")
        id = Invoice.last.id 
        created_at = Invoice.last.created_at
    
        get "/api/v1/invoices/find?created_at=#{created_at}"
    
        invoice = JSON.parse(response.body)
   
        expect(invoice["id"]).to eq(id)
    end 
    it "can find first invoice by updated at" do
        create(:invoice, updated_at: "2018-05-31 12:12:12 UTC")
        id = Invoice.last.id
        updated_at = Invoice.last.updated_at

        get "/api/v1/invoices/find?updated_at=#{updated_at}"

        invoice = JSON.parse(response.body)
        
        expect(response).to be_successful
        expect(invoice["id"]).to eq(id)
    end 
    it "can find all invoices by customer id " do
        invoice = create_list(:invoice, 3).first

        get "/api/v1/invoices/find_all?customer_id=#{invoice.customer_id}"

        invoices = JSON.parse(response.body)

        expect(response).to be_successful
        expect(invoices.first["customer_id"]).to eq(invoice.customer_id)
    end 
    it "can find all invoices by merchant id" do
        invoice = create_list(:invoice, 3).first

        get "/api/v1/invoices/find_all?merchant_id=#{invoice.merchant_id}"

        invoices = JSON.parse(response.body)

        expect(response).to be_successful
        expect(invoices.first["merchant_id"]).to eq(invoice.merchant_id)
    end 
    it "can find all invoices by status" do
        create(:invoice, status: "shipped")
        create_list(:invoice, 3, status: "paid")
        status = Invoice.last.status

        get "/api/v1/invoices/find_all?status=paid"

        invoices = JSON.parse(response.body)
        
        expect(response).to be_successful
        
        expect(invoices.count).to eq(3)
    end 
    it "can find all invoices by created at" do
        create(:invoice)
        create_list(:invoice, 3, created_at: "2018-04-31 12:12:12 UTC")
        created_at = Invoice.last.created_at
    
        get "/api/v1/invoices/find_all?created_at=#{created_at}"
    
        invoices = JSON.parse(response.body)
    
        expect(response).to be_successful
        expect(invoices.count).to eq(3)
    end 
    it "can find all invoices by updated at" do
        create(:invoice)
        create_list(:invoice, 3, updated_at: "2018-04-31 11:11:11 UTC")
        updated_at = Invoice.last.updated_at
    
        get "/api/v1/invoices/find_all?updated_at=#{updated_at}"
    
        invoices = JSON.parse(response.body)
    
        expect(response).to be_successful
        expect(invoices.count).to eq(3)
    end 
    it 'can return a random invoice' do
        invoices = create_list(:invoice, 5)
    
        get '/api/v1/invoices/random'
    
        invoice = JSON.parse(response.body)
    
        expect(response).to be_successful
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