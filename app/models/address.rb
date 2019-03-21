class Address < ApplicationRecord
  belongs_to :user

  validates :zip_code, format: { with: /\A\d{7}\Z/ }, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :address_line1, presence: true
  validates :phone_number, format: { with: /\A\d{10}\Z|\A\d{11}\Z/ }, presence: true
end
