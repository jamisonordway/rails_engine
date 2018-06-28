class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def revenue

  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions]).
    merge(Transaction.successful).
    order("sum(invoice_items.quantity) DESC").
    group("merchants.id").
    limit(quantity)
  end

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions]).
    merge(Transaction.successful).
    order("sum(invoice_items.quantity * invoice_items.unit_price) DESC").
    group("merchants.id").
    limit(quantity)
  end

  def self.date_total_merchant_revenue(merchant_id, date)
    where(["merchants.id = ? and merchants.created_at = ?", merchant_id, date])
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue DESC")
    .first
  end
end
