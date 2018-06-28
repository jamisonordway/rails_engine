class InvoiceSerializer < ActiveModel::Serializer
    attributes :id, :customer_id, :merchant_id, :status

    def unit_price
        (object.unit_price.to_f.round(2)).to_s
      end
end 
