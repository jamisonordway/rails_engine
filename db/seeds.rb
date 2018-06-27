10.times do
    Item.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Hipster.words,
      unit_price: Faker::Commerce.price,
      merchant_id: rand(1..10),
    )
  end
  
  10.times do
    Invoice.create!(invoice_id: rand(100000..999999))
  end
  
  100.times do
    InvoiceItem.create!(
      item_id: rand(1..10),
      invoice_id: rand(1..10),
      unit_price: rand(100..10000),
      quantity: rand(1..10),
    )
  end
