10.times do
  Merchant.create!(
    name: Faker::RickAndMorty.character
  )
end

10.times do
    Item.create!(
      name: Faker::HowIMetYourMother.character,
      description: Faker::Hipster.words,
      unit_price: rand(1..100),
      merchant_id: rand(1..10),
    )
  end

  10.times do
    Customer.create!(
      first_name: Faker::Simpsons.character,
      last_name: Faker::HitchhikersGuideToTheGalaxy.character
    )
  end

  10.times do
    Invoice.create!(
      customer_id: rand(1..10),
      merchant_id: rand(1..10),
      status: "shipped"
    )
  end

  100.times do
    InvoiceItem.create!(
      item_id: rand(1..10),
      invoice_id: rand(1..10),
      quantity: rand(1..10)
    )
  end
