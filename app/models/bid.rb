class Bid < ApplicationRecord
  belongs_to :maintenance_request
  belongs_to :contractor
end
