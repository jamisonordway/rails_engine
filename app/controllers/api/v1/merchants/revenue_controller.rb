class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if params["date"]
      render json: Merchant.find(params[:id]).date_total_merchant_revenue(params["date"]), serializer: MerchantRevenueSerializer
    else
      render json: Merchant.find(params[:id]).date_total_merchant_revenue, serializer: MerchantRevenueSerializer
    end
  end
end
