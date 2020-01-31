class Contractor < ApplicationRecord
  has_secure_password
  has_many :maintenance_requests
end
