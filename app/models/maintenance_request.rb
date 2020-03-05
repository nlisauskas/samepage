class MaintenanceRequest < ApplicationRecord
  belongs_to :property
  belongs_to :user
  has_many :bids
  has_many_attached :photos
  has_many :comments, as: :commentable
end
