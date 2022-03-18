class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :image, presence: true

  def get_image(width, height)
   image.variant(resize_to_limit: [width, height]).processed
  end

  def add_tax_price
        (self.price * 1.10).round
  end
end
