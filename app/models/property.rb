class Property < ApplicationRecord
  belongs_to :user
  has_many :tenants
  has_many :maintenance_requests
end
