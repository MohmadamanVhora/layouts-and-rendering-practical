class Product < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :title, presence: true
  validates :price, numericality: true, presence: true
  validates :description, presence: true, length: {maximum: 30}
  validates :product_status, inclusion: { in: %w[in_stock out_of_stock coming_soon] }

  enum :status, {'In stock': 'in_stock', 'Out of stock': 'out_of_stock', 'Coming soon': 'coming_soon'}
end
