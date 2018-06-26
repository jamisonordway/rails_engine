class Api::V1::Merchants::RandomController < ApplicationController

  def show
    id = rand(Merchant.first.id..Merchant.last.id)
    render json: Merchant.find(id)
  end
end
