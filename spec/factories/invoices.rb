FactoryBot.define do
  factory :invoice do
    customer 
    merchant 
    status "paid"
  end
end
