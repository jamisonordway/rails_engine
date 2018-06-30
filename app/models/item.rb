class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order('items.id DESC') }


  def self.most_revenue(item)
    joins(:invoices, :invoice_items).
    order("sum(invoice_items.quantity * invoice_items.unit_price) DESC").
    group("items.id").
    limit(item)
  end

  def self.most_items(item)
    joins(invoice_items: [:invoice]).
    merge(Invoice.successful).
    group(:id).
    order('sum(invoice_items.quantity) ').
    limit(item)
end


end
