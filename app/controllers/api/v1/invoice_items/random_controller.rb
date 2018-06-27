class Api::V1::InvoiceItems::RandomController < ApplicationController

    def show
        id = rand(InvoiceItem.first.id..InvoiceItem.last.id)
        render json: InvoiceItem.find(id)
    end 

end 