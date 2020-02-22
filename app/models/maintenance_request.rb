class MaintenanceRequest < ApplicationRecord
  belongs_to :property
  belongs_to :user
  has_many :bids
  has_one_attached :photo
  has_many :comments, as: :commentable
end
