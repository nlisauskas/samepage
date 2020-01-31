class User < ApplicationRecord
  has_secure_password
  has_many :properties
  has_many :tenants
  has_many :maintenance_requests
  has_many :contractors, through: :maintenance_requests
end
