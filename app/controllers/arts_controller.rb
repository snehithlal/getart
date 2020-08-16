class ArtsController < ApplicationController
  before_action :login_required, except: [:index]

  def index
    @arts = "Hiii"
  end
    
end
