FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number "86753098675309"
    result "cool"
  end
end
