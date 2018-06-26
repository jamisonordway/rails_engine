class Api::V1::Transactions::RandomController < ApplicationController

  def show
    id = rand(Transaction.first.id..Transaction.last.id)
    render json: Transaction.find(id)
  end
end
