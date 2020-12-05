Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :user do
    collection do
      get :login
      post :login
      get :sign_up
      post :sign_up
      get :logout
      get :dashboard
      get :resend_otp
      get :forgot_password
      post :forgot_password
      patch :forgot_password
      post :register_as_seller
      get :register_as_seller
      patch :register_as_seller
      get :complete_signup
      patch :complete_signup
    end
  end

  resources :products do
    collection do
      get :sell_art
    end
    
    member do
      get :buy_again
    end
  end
  
  resources :orders do
    collection do
    end
    
    member do
      get :cancel
      get :view_invoice
      get :download_invoice
    end
  end
  
  resources :addresses do
    collection do
    end
    
    member do
      get :set_as_default
    end
  end
  
  resources :coupons do
    collection do
    end
    
    member do
    end
  end
  
  resources :payments do
    collection do
    end
    
    member do
    end
  end
  
  resources :help do
    collection do
    end
    
    member do
    end
  end
  
  root 'arts#index'
end
