class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :merchant_id
  attribute  :unit_price

  def unit_price
    (object.unit_price.to_f.round(2) / 100).to_s
  end
end
