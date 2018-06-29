class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant


  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  scope :created_today, -> { where('created_at > ? AND created_at < ?', Time.now.beginning_of_day, Time.now.tomorrow.beginning_of_day)}

  scope :successful, -> { joins(:transactions).where(transactions: {result: 'success'}) }

  def total_revenue
    invoice_items.pluck(:unit_price)
  end
end
