class Address < ApplicationRecord
  belongs_to :employee
  validates :house_name, :street_name, :road, presence: true
end
