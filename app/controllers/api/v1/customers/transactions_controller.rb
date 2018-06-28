class Api::V1::Customers::TransactionsController < ApplicationController

    def index
        #binding.pry
        render json: Customer.find(params[:id]).transactions
    end
    
end 