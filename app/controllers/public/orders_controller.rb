class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = 0
  end
  
  def thanks
  end
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save!
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new(order_id: @order.id)
        order_detail.price = cart_item.item.price
        order_detail.amount = cart_item.amount
        order_detail.item_id = cart_item.item_id
        order_detail.making_status = 1
        order_detail.save!
      end
      @cart_items.destroy_all
      redirect_to public_orders_thanks_path
    else
      render "new"
    end
  end

  
  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]
    @total = 0
    @order.shipping_cost = 800
    @order.status = 0

    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + " " + current_customer.first_name
      render 'confirm'
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.shipping_address
      @order.name = @address.name
      render 'confirm'
    elsif params[:order][:select_address] == "2"
      @shipping_address = current_customer.shipping_address.new
      @shipping_address.address = params[:order][:address]
      @shipping_address.name = params[:order][:name]
      @shipping_address.postal_code = params[:order][:postal_code]
      @shipping_address.customer_id = current_customer.id
      if @shipping_address.save
      @order.postal_code = @shipping_address.postal_code
      @order.name = @shipping_address.name
      @order.address = @shipping_address.address
      else
       render 'new'
      end
    end
  end


private
def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost, :status)
end
end
