class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  validates :image, :name, :introduction, :genre_id, :price, presence: true

  attachment :image
end
