class Admin::OrdersController < ApplicationController
  
  
  
  
  
  
    private
    
    def order_params
      params.require(:order).
      permit(:postal_code, :address, :name, :shipping_cost, 
      :total_payment, :payment_method, :status )
    end
end
