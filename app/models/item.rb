class Item < ApplicationRecord
    belongs_to :genre
    has_many :cart_items
    has_one_attached :image
    
    #消費税10％加算メソッド
def with_tax_price
    (price * 1.1).floor
end
end
