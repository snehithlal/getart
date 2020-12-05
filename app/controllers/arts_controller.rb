class ArtsController < ApplicationController
  before_action :login_required, except: [:index] #remove if not needed

  def index
    @categories = Category.all.includes(:subcategories)
  end
  
end
