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


  def self.best_day(item_id)
    find_by_sql("select invoices.created_at, count(invoices.created_at) as total_day_sales from invoices inner join invoice_items on invoice_items.invoice_id=invoices.id inner join transactions on transactions.invoice_id=invoices.id inner join items on invoice_items.item_id=items.id where items.id=#{item_id} and transactions.result='success' group by invoices.created_at order by total_day_sales DESC, invoices.created_at DESC")
  end 

end
