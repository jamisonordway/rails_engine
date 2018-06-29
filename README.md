# Rails Engine

The Rails Engine app manages data to execute business intelligence queries. The user can review sales engine data for merchants, items, invoices, invoice items, transactions, and customers. This application uses Ruby on Rails 5.2, ActiveRecord, and the tests are done with FactoryBot and RSpec.

In order to "seed" the data, we created a rake task that parses through the CSVs from the spec harness in the lib/task folder. You import the CVSs by running rake import:all.
