class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    object.revenue
  end
end
