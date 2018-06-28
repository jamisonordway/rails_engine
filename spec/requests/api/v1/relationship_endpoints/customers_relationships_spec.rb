require 'rails_helper'

describe "Customer API" do
    describe "relationships" do 
        it "can return invoice associated with a customer" do
            create(:customer, id: 5)
            create(:invoice, customer_id: 5)
            create(:customer, id: 9)
            create_list(:invoice, 5, customer_id: 9)
            customer_id = Customer.last.id

            get "/api/v1/customers/#{customer_id}/invoices"

            invoices = JSON.parse(response.body)

            expect(response).to be_successful
            expect(invoices.count).to eq(5)
        end 
        it "can return transactions associated with a customer" do
            create(:customer, id: 2)
            create(:invoice, id: 5, customer_id: 2)
            create_list(:transaction, 5, invoice_id: 5)
            create(:customer, id: 1)
            create(:invoice, id: 6, customer_id: 1)
            create_list(:transaction, 6, invoice_id: 6)

            customer_id = Customer.last.id
            get "/api/v1/customers/#{customer_id}/transactions"

            transactions = JSON.parse(response.body)
            expect(response).to be_successful
            expect(transactions.count).to eq(5)
        end 
    end 
end 