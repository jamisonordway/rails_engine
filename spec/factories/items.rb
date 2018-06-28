FactoryBot.define do
  factory :item do
    name "Cool Item"
    description "Best description ever"
    unit_price 1
    merchant
    created_at "2018-04-31 11:11:11 UTC"
    updated_at "2018-04-31 11:11:11 UTC"
  end
end