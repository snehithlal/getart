class ArtsController < ApplicationController
  before_action :login_required, except: [:index]

    def index
        @categories = Category.all
    end
    
end
