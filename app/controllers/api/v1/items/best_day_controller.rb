class Api::V1::Items::BestDayController < ApplicationController
    def show
      render json: Invoice.best_day(params[:id]), serializer: BestDaySerializer
    end
  end