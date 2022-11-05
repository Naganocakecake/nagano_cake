class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @total = 0
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    if @order_detail.making_status == "production"
       @order.status = "production"
       @order.save
    elsif @order.order_details.count ==  @order.order_details.where(making_status: "production_completed").count
      @order.status = "shipping_preparation"
      @order.save
    end 
       redirect_to admin_order_path(@order)
  end

      
  private
    def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status )
    end
end