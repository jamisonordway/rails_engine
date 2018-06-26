require 'rails_helper'

describe 'merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
  end

  it 'can show one merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it 'can create a new merchant' do
    merchant_params = { name: "Bob" }

    post '/api/v1/merchants', params: {merchant: merchant_params}
    merchant = Merchant.last

    assert_response :success
    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it 'can update an existing merchant' do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Silent Bob" }

    put "/api/v1/merchants/#{id}", params: {merchant: merchant_params}

    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Silent Bob")
  end

  it 'can destroy a merchant' do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
