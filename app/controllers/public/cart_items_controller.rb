class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end
  
	def create
	if current_customer.cart_items.count >= 1 
	  if nil != current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
		   @cart_item_u = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
		   @cart_item_u.amount += params[:cart_item][:amount].to_i
		   @cart_item_u.update(amount: @cart_item_u.amount)
		   redirect_to public_cart_items_path
	  else
			 	@cart_item = CartItem.new(cart_item_params) 
			@cart_item.customer_id = current_customer.id 
			if @cart_item.save 
				 redirect_to public_cart_items_path 
			else
				@items = Item.where(sale_status: true).page(params[:page]).per(8) 
		    @quantity = Item.count 
		    @genres = Genre.where(valid_invalid_status: 0)
				render 'index' 
			end
	  end

	else
		@cart_item = CartItem.new(cart_item_params)
		@cart_item.customer_id = current_customer.id
		if @cart_item.save
			 redirect_to public_cart_items_path
		else
			@items = Item.where(sale_status: true).page(params[:page]).per(8)
	    @quantity = Item.count
	    @genres = Genre.where(valid_invalid_status: 0)
			render 'index'
		end
		
	end
	end

	def update
		@cart_item = CartItem.find(params[:id])
		@cart_item.update(cart_item_params)
		redirect_to public_cart_items_path
	end

	def destroy
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to public_cart_items_path
	end

	def destroy_all
		@cart_items = current_customer.cart_items
		@cart_items.destroy_all
		redirect_to public_cart_items_path
	end

end
  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
