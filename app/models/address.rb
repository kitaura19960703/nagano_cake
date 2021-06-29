class Address < ApplicationRecord
  belongs_to :customer
  validates :name, :postal_code, :address, presence: true

  def address_info
    [postal_code, address, name].join(' ')
  end
end
