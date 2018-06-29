class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  def unit_price
    price = (object.unit_price).to_f / 100
    object.unit_price = price.to_s
  end
end
