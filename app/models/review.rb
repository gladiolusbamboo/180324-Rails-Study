class Review < ApplicationRecord
  belongs_to :cd
  belongs_to :listener
end
