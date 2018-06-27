class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.successful
    where(result: 'success')
  end
end
