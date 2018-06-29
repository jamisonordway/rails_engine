class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  default_scope { order('items.id DESC') }

  # def best_day
  #   binding.pry
  #  invoices.joins(:invoice_items)
  #   .order("invoice_items.quantity DESC, invoices.created_at DESC")
  #   .first.created_at


    # invoice_items
    # .joins(invoice: :transactions)
    # .merge(Transaction.unscoped.successful)
    # .group(:created_at)
    # .order('invoice_items.quantity desc')
    # .first
    # .invoice
    # .created_at
#   end
end
