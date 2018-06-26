FactoryBot.define do
  factory :item do
    name "Cool Item"
    description "Best description ever"
    unit_price 1
    merchant
    created_at "2012-03-27 14:53:59 UTC"
    updated_at "2012-03-27 14:53:59 UTC"
  end
end