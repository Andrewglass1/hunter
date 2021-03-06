Hunter::Application.routes.draw do

  devise_for :users

  root :to => 'welcome#show'
  resources :markets
  resources :deals
  resources :merchants
  resources :users, :only => [:show]
  resources :user_markets
  resources :welcome, :only => [:show]
  match '/markets/:id/stats' => 'markets#stats', :as => :market_stats


end
