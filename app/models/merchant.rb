class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices

  def revenue
    # get all invoice_items for merchant
    InvoiceItem.joins(invoice: [:merchant])
    # use those to get revenue
  end

  def num_items
    Item.where(merchant_id: id).count
  end

  def self.most_items(quantity)
    Item.group(:merchant_id).order('count_all DESC').count
  end
end
