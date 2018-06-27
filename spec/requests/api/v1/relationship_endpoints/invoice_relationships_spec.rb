describe 'invoices API' do
    describe 'relationships' do
      it "can return all transactions associated with an invoice" do
        invoices = create_list(:invoice, 7)
  
        100.times do 
            create(:transaction, invoice: invoices.sample)
        end 
        
        get "/api/v1/invoices/#{invoices[3].id}/transactions"
  
        transactions = JSON.parse(response.body)
        
        expect(response).to be_successful
        expect(invoices[3].transactions.count).to eq(transactions.count)
      end
      it "can return all invoice_items associated with an invoice" do
        invoices = create_list(:invoice, 7)
        100.times do 
            create(:invoice_item, invoice: invoice_list.sample)
        end
        
        get "/api/v1/invoices/#{invoices[3].id}/invoice_items"

        invoice_items = JSON.parse(response.body)

        expect(response).to be_successful
        expect(invoices[3].invoice_items.count).to eq(invoice_items.count)
      end
      it "can return all items associated with an invoice" do
        items = create_list(:item, 20)
        invoices = create_list(:invoice, 20)
        100.times do
            create(:invoice_item, invoice: invoices.sample, item: items.sample)
        end 

        get "/api/v1/invoices/#{invoices[3].id}/items"

        items = JSON.parse(response.body)

        expect(response).to be_successful
        expect(invoices[3].items.count).to eq(items.count)
      end 
      it "can return the customer associated with an invoice" do
        customers = create_list(:customer, 5)
        8.times do
            create(:invoice, customer: customers.sample)
        end

        get "/api/v1/invoices/#{Invoice.first.id}/customer"

        customer = JSON.parse(response.body)

        expect(response).to be_successful
        expect(Invoice.first.customer.id).to eq(customer["id"])
      end
      it "can return the merchant associated with an invoice" do
        merchants = create_list(:merchant, 5)
        8.times do
            create(:invoice, merchant: merchant_list.sample)
        end

        get "api/v1/invoices/#{Invoice.first.id}/merchant"

        merchant = JSON.parse(response.body)

        expect(response).to be_successful
        expect(Invoice.first.merchant.id).to eq(merchant["id"])
      end 
    end 