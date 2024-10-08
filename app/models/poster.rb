class Poster < ApplicationRecord
  scope :sort_asc, -> (sort) {order(created_at: :asc) if sort=="asc"}
  scope :sort_dsc, -> (sort) {order(created_at: :desc) if sort=="desc"}
  scope :filter_by_name, -> (name) {where("name ILIKE '%#{name}%'").order(name: :asc) if name.present?}
  scope :filter_by_min_price, -> (min_price) {where("price >= #{min_price}") if min_price.present?}
  scope :filter_by_max_price, -> (max_price) {where("price <= #{max_price}") if max_price.present?}

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :year, presence: true, numericality: { only_integer: true}
  validates :price, presence: true, numericality: { only_float: true }
  validates :vintage, inclusion: [true, false]
  validates :vintage, exclusion: [nil]
end
