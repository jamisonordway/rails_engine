class InvoiceItemsSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  def unit_price
    (object.unit_price.to_f.round(2)).to_s
  end
end
