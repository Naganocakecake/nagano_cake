class Order < ApplicationRecord

#アソシエーション

      has_many :order_details, dependent: :destroy
      belongs_to :customer

#enum設定
enum payment_method: { credit_card: 0, transfer: 1 }

end
