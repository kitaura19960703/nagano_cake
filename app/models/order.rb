class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  enum payment_method: { クレジットカード: 0, 銀行振込: 1, }
  enum status: { 入金待ち: 0, 入金確認: 1, 制作中: 2, 発送準備中: 3, 発送済み: 4, }

  # validates :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_code, :email, presence: true
end
