class Category2 < ApplicationRecord
  belongs_to :category1, optional: true
  has_many :category3s, -> { order(:id) }
end
