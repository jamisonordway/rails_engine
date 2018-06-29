# Rails Engine

The Rails Engine app manages data to execute business intelligence queries. The user can review sales engine data for merchants, items, invoices, invoice items, transactions, and customers. This application uses Ruby on Rails 5.2, ActiveRecord, and the tests are done with FactoryBot and RSpec.

In order to "seed" the data, we created a rake task that parses through the CSVs from the spec harness in the lib/task folder. You import the CVSs by running rake import:all.

# Set up and Installation

1. clone down the repo.
`git clone git@github.com:jamisonordway/rails_engine.git`
`bundle updat`

2. Set up the migration.
`rake db:{create, migrate}`

3. Import the CSV data.
` rake import:all`

4. Once the database has been seeded you can run the tests.
`rspec`

5. You can then run the server. 
`rails s`

6. You can then go to localhost:3000/api/v1/____(url of choice) which can be located in the routes file under config. 
