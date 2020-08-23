class ArtsController < ApplicationController

    def index
        @categories = Category.all
    end
    
end
