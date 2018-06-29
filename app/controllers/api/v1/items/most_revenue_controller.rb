class Api::V1::Items::MostRevenueController < ApplicationController
  def show
    render json: Item.most_revenue(params[:quantity])
  end
end
