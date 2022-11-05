class Admin::HomesController < ApplicationController
  
  def top
    @order_details = OrderDetail
    @order_details = OrderDetail.page(params[:page])
  end



end