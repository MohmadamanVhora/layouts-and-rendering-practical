class Order < ApplicationRecord
  belongs_to :product
  
  validates :quantity, presence: true
  validates :order_status, inclusion: { in: %w[booked canceled] }
  enum :status, { 'Booked': 'booked', 'Canceled': 'canceled' }
end
