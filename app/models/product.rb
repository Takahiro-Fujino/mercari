class Product < ApplicationRecord
  has_many :product_images, dependent: :destroy
  has_one :order, dependent: :destroy
  belongs_to :user, optional: true
  accepts_nested_attributes_for :product_images
  belongs_to :category1
  belongs_to :category2
  belongs_to :category3
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :name, presence: true, length: { maximum: 40 }
  validates :product_description, presence: true, length: { maximum: 1000 }
  validates :category1, presence: true
  validates :condition, presence: true
  validates :postage, presence: true
  validates :ship_from, presence: true
  validates :shipping_date, presence: true
  validates :price, presence: true

  mount_uploader :image, ImageUploader
end
