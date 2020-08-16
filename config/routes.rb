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
    end
  end
  root 'arts#index'
end
