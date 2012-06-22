Hunter::Application.routes.draw do

  root :to => 'markets#index'
  resources :markets
  resources :deals

end
