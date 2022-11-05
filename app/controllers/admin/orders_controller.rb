class Admin::OrdersController < ApplicationController
  
  def index
        @order_details = @order.order_details.all
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
  end  
  
  def update
    @order = Order.find(params[:id])
    @total = 0
    @order.update(order_params)
    @order_details = @order.order_details
    if @order.status == "payment_confirmation"
        @order_details.each do |order|
        order.making_status = "waiting_for_production"
        order.save
        end
    end
      redirect_to admin_order_path(@order)
  end
  
  
    private
    
    def order_params
      params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status )
    end
end
