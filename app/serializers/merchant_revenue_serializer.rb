class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    object.invoices.map {|invoice| invoice.total_revenue}.flatten.sum
  end
end
