class Customer < ApplicationRecord
    has_many :invoices
    has_many :transactions, through: :invoices
    has_many :merchants, through: :invoices

  def favorite_merchant
    merchants
    .select("merchants.*, count(invoices.merchant_id) AS merchant_count")
    .joins(invoices: [:transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("merchant_count DESC")
    .limit(1)
    .first
  end

  
end
