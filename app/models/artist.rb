class Artist < ApplicationRecord
  belongs_to :listener
  has_and_belongs_to_many :cds
  has_many :comments, -> { where(deleted: false) }, class_name: 'FanComment',
    foreign_key: 'artist_no'

  has_many :memos, as: :memoable

end
