class Api::V1::Invoices::RandomController < ApplicationController

  def show
      id = rand(Invoice.first.id..Invoice.last.id)
      render json: Invoice.find(id)
  end

end
