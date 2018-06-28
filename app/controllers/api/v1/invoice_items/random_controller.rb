class Api::V1::InvoiceItems::RandomController < ApplicationController

    def show
        id = InvoiceItem.all.sample.id
        
        render json: InvoiceItem.find(id)
    end 

end 