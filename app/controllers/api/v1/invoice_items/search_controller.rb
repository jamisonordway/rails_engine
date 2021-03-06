class Api::V1::InvoiceItems::SearchController < ApplicationController

    def index
        render json: InvoiceItem.where(search_params)
    end

    def show
        render json: InvoiceItem.find_by(search_params)
    end

    private

    def search_params
        if params[:unit_price]
            params[:unit_price] = params[:unit_price].delete('.')
        end
        params.permit(:id, :customer_id, :merchant_id, :item_id, :unit_price, :invoice_id, :status, :created_at, :updated_at, :quantity)
    end 
end
