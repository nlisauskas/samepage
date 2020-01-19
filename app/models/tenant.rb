class Tenant < ApplicationRecord
  belongs_to :property
  belongs_to :user
  has_many :maintenance_requests
end
