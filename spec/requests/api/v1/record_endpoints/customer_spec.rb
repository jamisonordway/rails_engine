require 'rails_helper'

describe 'customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'
    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers.count).to eq(3)
  end

  it 'can show one customer by id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  it 'can create a new customer' do
    id = create(:invoice).id
    customer_params = { first_name: 'Silent', last_name: 'Bob' }

    post '/api/v1/customers', params: {customer: customer_params}
    customer = Customer.last

    assert_response :success
    expect(response).to be_successful
    expect(customer.first_name).to eq(customer_params[:first_name])
    expect(customer.last_name).to eq(customer_params[:last_name])
  end

  it 'can update an existing customer' do
    id = create(:customer).id
    previous_name = Customer.last.first_name
    customer_params = { first_name: 'What about Bob' }

    put "/api/v1/customers/#{id}", params: {customer: customer_params}

    customer = Customer.find_by(id: id)

    expect(response).to be_successful
    expect(customer.first_name).to_not eq(previous_name)
    expect(customer.first_name).to eq('What about Bob')
  end

  it 'can destroy a customer' do
    customer = create(:customer)

    expect(Customer.count).to eq(1)

    delete "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful
    expect(Customer.count).to eq(0)
    expect{Customer.find(customer.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can search by the id' do
    id = create(:customer).id

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(Customer.count).to eq(1)
    expect(customer["id"]).to eq(id)
  end

  it 'can search by first_name' do
    first_name = create_list(:customer, 2).first.first_name

    get "/api/v1/customers/find_all?first_name=#{first_name}"

    customers = JSON.parse(response.body)
    expect(response).to be_successful

    expect(customers.first["first_name"]).to eq(first_name)
    expect(customers.count).to eq(2)
  end
  it 'can search by first_name and is case insensitive' do
    customer_1 = create(:customer, first_name: 'jamison')
    customer_2 = create(:customer, first_name: 'sabrina')

    get "/api/v1/customers/find?first_name=#{customer_1.first_name.upcase}"

    customer = JSON.parse(response.body)
    
    expect(response).to be_successful
  
    expect(customer["id"]).to eq(customer_1.id)
  end 

  it 'can search by last_name' do
    last_name = create_list(:customer, 15).first.last_name

    get "/api/v1/customers/find_all?last_name=#{last_name}"

    customers = JSON.parse(response.body)
    expect(response).to be_successful

    expect(customers.first["last_name"]).to eq(last_name)
    expect(customers.count).to eq(15)
  end

  it 'can search by last_name and is case insensitive' do
    customer_1 = create(:customer, last_name: 'smith')
    customer_2 = create(:customer, last_name: 'jones')

    get "/api/v1/customers/find?last_name=#{customer_1.last_name.upcase}"

    customer = JSON.parse(response.body)
    
    expect(response).to be_successful
  
    expect(customer["id"]).to eq(customer_1.id)
  end 
  it 'can search a random customer' do
    customers = create_list(:customer, 5)

    get '/api/v1/customers/random'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
  end

  it 'can search by created_at date' do
    customers = create(:customer,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/customers/find?created_at=#{customers.created_at}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(customers.id)
    expect(customer["first_name"]).to eq(customers.first_name)
    expect(customer["last_name"]).to eq(customers.last_name)
  end

  it 'can search by updated_at' do
    customers = create(:customer,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/customers/find?created_at=#{customers.created_at}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(customers.id)
    expect(customer["first_name"]).to eq(customers.first_name)
    expect(customer["last_name"]).to eq(customers.last_name)
  end
end
