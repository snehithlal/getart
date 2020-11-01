class ProductsController < ApplicationController
  before_action :login_required, except: [:index]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all.includes(:subcategories)
  end

  def create
    @product = Product.new(permitted_params)
    if @product.save
      flash[:notice] = "Product Created"
    else
      flash[:alert] = @product.errors.full_messages
    end
    redirect_to action: "new"
  end

  def sell_art
  end
  
  private

  def permitted_params
    params.require(:product).permit(:name, :description, :user_id, {images: []})
  end

end
