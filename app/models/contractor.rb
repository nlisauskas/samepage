class Contractor < ApplicationRecord
  has_secure_password
  has_many :maintenance_requests
  has_many :bids
end
