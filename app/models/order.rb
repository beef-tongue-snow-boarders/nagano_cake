class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, production: 2, preparing_delivery: 3, delivered: 4 }

  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :name, presence: true

  def total_amount
    number = 0
    self.order_details.each do |order_detail|
      number += order_detail.amount
    end
    number
  end
end
