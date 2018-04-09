class Review < ApplicationRecord
  belongs_to :cd
  belongs_to :listener

  default_scope{ order(updated_at: :desc) }
end
