class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, production: 2, preparing_delivery: 3, delivered: 4 }
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :name, presence: true
end
