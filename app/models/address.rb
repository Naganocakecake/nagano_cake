class Address < ApplicationRecord

belongs_to :customer
def address_display
  '〒' + postal_code + ' ' + shipping_address + ' ' + name
end
end
