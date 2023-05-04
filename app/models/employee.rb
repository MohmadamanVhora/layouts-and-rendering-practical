class Employee < ApplicationRecord
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses
  mount_uploader :document, DocumentUploader

  validates :name, :password, :gender, :birth_date, presence: true
  validates :email, presence: true, uniqueness: true
  validates :mobile_number, presence: true, numericality: true, length: { is: 10 }

  serialize :hobbies, Array

  enum gender: {Male: 0, Female: 1}
  HOBBY = ['Playing Cricket', 'Travelling', 'Reading Books']
end
