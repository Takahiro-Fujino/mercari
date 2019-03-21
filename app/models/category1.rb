class Category1 < ApplicationRecord
  has_many :category2s, -> { order(:id) }
end
