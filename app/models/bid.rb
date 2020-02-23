class Bid < ApplicationRecord
  belongs_to :maintenance_request
  belongs_to :contractor
  has_many :comments, as: :commentable

  validates :price, presence: true, unless: :info_requested
  validates :info_requested, presence: true, unless: :price
end
