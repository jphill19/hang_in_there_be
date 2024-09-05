class Poster < ApplicationRecord
  scope :sort_asc, -> (sort) {order(created_at: :asc) if sort=="asc"}
end
