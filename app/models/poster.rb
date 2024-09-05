class Poster < ApplicationRecord
  scope :sort_asc, -> (sort) {order(created_at: :asc) if sort=="asc"}
  scope :sort_dsc, -> (sort) {order(created_at: :desc) if sort=="desc"}
  scope :filter_by_name, -> (name) {where("name ILIKE '%#{name}%'") if name.present?}
end
