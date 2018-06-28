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
end
