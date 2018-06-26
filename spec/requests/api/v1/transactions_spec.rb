require 'rails_helper'

describe 'transactions API' do
  it 'sends a list of transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'
    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(3)
  end

  it 'can show one transaction by id' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["id"]).to eq(id)
  end

  xit 'can create a new transaction' do
    id = create(:invoice).id
    transaction_params = { invoice_id: id, credit_card_number: "86753098672206" }

    post '/api/v1/transactions', params: {transaction: transaction_params}
    transaction = Transaction.last

    assert_response :success
    expect(response).to be_successful
    expect(transaction.credit_card_number).to eq(transaction_params[:credit_card_number])
  end

  it 'can update an existing transaction' do
    id = create(:transaction).id
    previous_card = Transaction.last.credit_card_number
    transaction_params = { credit_card_number: "86753098675388" }

    put "/api/v1/transactions/#{id}", params: {transaction: transaction_params}

    transaction = Transaction.find_by(id: id)

    expect(response).to be_successful
    expect(transaction.credit_card_number).to_not eq(previous_card)
    expect(transaction.credit_card_number).to eq("86753098675388")
  end

  it 'can destroy a transaction' do
    transaction = create(:transaction)

    expect(Transaction.count).to eq(1)

    delete "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_successful
    expect(Transaction.count).to eq(0)
    expect{Transaction.find(transaction.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can search by the id' do
    id = create(:transaction).id

    get "/api/v1/transactions/find?id=#{id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(Transaction.count).to eq(1)
    expect(transaction["id"]).to eq(id)
  end

  it 'can search by invoice_id' do
    invoice = create(:transaction).invoice_id

    get "/api/v1/transactions/find_all?invoice_id=#{invoice}"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful

    expect(transactions.first["invoice_id"]).to eq(invoice)
    expect(transactions.count).to eq(1)
  end

  it 'can search by credit_card_number' do
    cc_number = create_list(:transaction, 2).first.credit_card_number

    get "/api/v1/transactions/find_all?credit_card_number=#{cc_number}"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful

    expect(transactions.first["credit_card_number"]).to eq(cc_number)
    expect(transactions.count).to eq(2)
  end

  it 'can search all matching result' do
    transaction = create_list(:transaction, 3).first

    get "/api/v1/transactions/find_all?result=#{transaction.result}"

    transactions = JSON.parse(response.body)
    expect(response).to be_successful

    expect(transaction["result"]).to eq(transaction.result)
    expect(transactions.count).to eq(3)
  end

  it 'can search a random transaction' do
    transactions = create_list(:transaction, 5)

    get '/api/v1/transactions/random'

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
  end

  xit 'can search by created_at date' do
    transactions = create(:transaction,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/transactions/find?created_at=#{transactions.created_at}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transactions.id)
    expect(transaction["name"]).to eq(transactions.name)
    # expect(transaction["created_at"]).to eq(transactions.created_at)
  end

  xit 'can search by updated_at' do
    transactions = create(:transaction,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/transactions/find?created_at=#{transactions.created_at}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transactions.id)
    expect(transaction["name"]).to eq(transactions.name)
    # expect(transaction["updated_at"]).to eq(transactions.updated_at)
  end
end
