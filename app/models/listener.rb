class Listener < ApplicationRecord
  has_one :artist
  has_many :reviews
  has_many :cds, through: :reviews
end
