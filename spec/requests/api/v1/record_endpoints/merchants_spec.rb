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

  it 'can search by name' do
    name = create_list(:merchant, 3).first.name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(Merchant.count).to eq(3)
    expect(merchant["name"]).to eq(name)
  end

  it 'can search by case insensitive name' do
    name = create(:merchant, name: 'bob ross store').name

    get "/api/v1/merchants/find?name=#{name.upcase}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)
    expect(Merchant.count).to eq(1)
    expect(merchant["name"]).to eq(name)
  end 

  it 'can search all matching names' do
    merchant = create_list(:merchant, 3).first

    get "/api/v1/merchants/find_all?name=#{merchant.name}"

    merchants = JSON.parse(response.body)
    expect(response).to be_successful

    expect(merchant["name"]).to eq(merchant.name)
    expect(merchants.count).to eq(3)
  end

  it "can search all case insenstive matching names" do
    merchant = create_list(:merchant, 3).first
    
    get "/api/v1/merchants/find_all?name=#{merchant.name.upcase}"

    merchants = JSON.parse(response.body)
    expect(response).to be_successful

    expect(merchant["name"]).to eq(merchant.name)
    expect(merchants.count).to eq(3)
  end 

  it 'can search a random merchant' do
    merchants = create_list(:merchant, 5)

    get '/api/v1/merchants/random'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
  end

  it 'can search by created_at date' do
    merchants = create(:merchant,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find?created_at=#{merchants.created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchants.id)
    expect(merchant["name"]).to eq(merchants.name)
  end

  it 'can search by updated_at' do
    merchants = create(:merchant,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find?created_at=#{merchants.created_at}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchants.id)
    expect(merchant["name"]).to eq(merchants.name)
  end
end
describe 'merchants API' do
  describe 'relationships' do
    it "can return all items associated with a merchant" do
      create(:merchant)
      id = Merchant.last.id
      id_2 = 2

      create(:merchant, id: id_2)
      create_list(:item, 5, merchant_id: id)
      create_list(:item, 9, merchant_id: id_2)
    
      get "/api/v1/merchants/#{id}/items"

      items = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(items.count).to eq(5)
    end
    it "can return all invoices associated with a merchant" do
      create(:merchant)
      id = Merchant.last.id
      id_2 = 2

      create(:merchant, id: id_2)
      create_list(:invoice, 4, merchant_id: id)
      create_list(:invoice, 8, merchant_id: id_2)

      
      get "/api/v1/merchants/#{id}/invoices"
      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices.count).to eq(4)
    end
  end 
end 