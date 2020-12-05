class OrdersController < ApplicationController

  def index
    @order_count = current_user_detail.orders.count
    @order_products = current_user_detail.user_order_products_by_type(params[:type]).
      includes(:order, :product).group_by(&:order).sort_by{|x, y| x.created_at}.reverse
  end
  
  def cancel
    head :ok
  end
  
  def view_invoice
    head :ok
  end
  
  def download_invoice
    head :ok
  end
  
  private
end
