require 'rails_helper'

describe 'Invoice items API' do
    describe 'relationships' do
        it 'can return invoice associated with invoice_item' do
            invoices = create_list(:invoice, 10)
            items = create_list(:item, 10)
            invoice_item = create(:invoice_item, item: items.sample, invoice: invoices.sample)

            get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

            invoice = JSON.parse(response.body)

            expect(response).to be_successful
            expect(invoice["id"]).to eq(invoice_item.invoice.id)
        end 
        it 'can return item associated with invoice_item' do
            invoices = create_list(:invoice, 10)
            items = create_list(:item, 10)
            invoice_item = create(:invoice_item, item: items.sample, invoice: invoices.sample)

            get "/api/v1/invoice_items/#{invoice_item.id}/item"

            item = JSON.parse(response.body)

            expect(response).to be_successful
            expect(item["id"]).to eq(invoice_item.item.id)
        end 
    end 
end 