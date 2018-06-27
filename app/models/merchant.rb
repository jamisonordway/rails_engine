class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def revenue
    # get all invoice_items for merchant
    InvoiceItem.joins(invoice: [:merchant])
    # use those to get revenue
  end

  def num_items
    Item.where(merchant_id: id).count
  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .order("sum(invoice_items.quantity) DESC")
    .group(:id)
    .limit(quantity)
    # select("merchants.*, sum(invoice_items.quantity) AS total")
    # .joins(:invoices [:invoice_items, :transactions])
    # .merge(Transaction.successful)
    # .order("total DESC")
    # .group("merchants.id")
    # .take(quantity)
    # Item.group(:merchant_id).order('count_all DESC').count.take(2)
  end
end
