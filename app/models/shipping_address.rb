class ShippingAddress < ApplicationRecord
  belongs_to :customer

  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :name, presence: true

  def shipping_address_display
    "〒" + postal_code + " " + address + " " + name
  end
end