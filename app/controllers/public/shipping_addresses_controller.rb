class Public::ShippingAddressesController < ApplicationController

def index
  @address = Address.new
  @addresses = current_customer.addresses
end

def create
	@address = Address.new(address_params)
	@address.customer_id = current_customer.id
	@address.save
  redirect_to public_shipping_addresses_path
end

def edit
  @address = Address.find(params[:id])
end

  def update
  @address = Address.find(params[:id])
  if @address.update(address_params)
  	redirect_to public_shipping_addresses_path
  else
    render :edit
  end
  end
  


  def destroy
  	@address = Address.find(params[:id])
  	@address.destroy
  	redirect_to public_shipping_addresses_path
  end

private
  def address_params
  	params.require(:address).permit(:name, :customer_id, :shipping_address, :postal_code)
  end

end
