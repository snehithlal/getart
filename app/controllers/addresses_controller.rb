class AddressesController < ApplicationController
  
  def index
    @recent_used_address = current_user_detail.addresses.find_by(last_used: true)
    @addresses = 
      (if @recent_used_address
        current_user_detail.addresses.where("id != ?", @recent_used_address.id)
      else
        current_user_detail.addresses
      end).order("updated_at desc").limit(3)
    @address = current_user_detail.address.build
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  def set_as_default
  end
end
