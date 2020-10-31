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
    end
  end

  resources :products
  root 'arts#index'
end
