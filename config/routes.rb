Hunter::Application.routes.draw do

  devise_for :users

  root :to => 'markets#index'
  resources :markets
  resources :deals
  resources :merchants
  resources :users, :only => [:show]
  resources :user_markets

end
