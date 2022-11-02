class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :item
    
    enum status: { cannot_be_manufactured: 0, waiting_for_production: 1, production: 2, production_completed: 3 }
end
