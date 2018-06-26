class Api::V1::Customers::RandomController < ApplicationController

  def show
    id = rand(Customer.first.id..Customer.last.id)
    render json: Customer.find(id)
  end
end
