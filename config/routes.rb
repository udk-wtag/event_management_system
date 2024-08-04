Rails.application.routes.draw do
  root 'home#index'

  resources :users
  get 'signup', to: 'users#new'

end
