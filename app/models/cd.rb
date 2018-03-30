class Cd < ApplicationRecord
  has_many :reviews
  has_and_belongs_to_many :artists
  has_many :listeners, through: :reviews
  has_many :memos, as: :memoable
end
