class Bid < ApplicationRecord
  belongs_to :maintenance_request
  belongs_to :contractor
  has_many :comments, as: :commentable
end
