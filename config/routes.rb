Rails.application.routes.draw do


  resources :clients
  resources :produits
  resources :users
  resources :factures
  root to: 'login#home'

  get 'login', to: 'login#login', as: 'login'
  post 'login', to: 'login#connect'
  get 'logout', to: 'login#disconnect', as:'logout'

  # API
  get 'api/factures', to: 'factures#api'



  # for test
  get 'test/putSession', to: 'login#put', as: 'put'
  get 'test/testSession', to: 'login#setSession', as: 'setsession'
  get 'test/clearSession', to: 'login#clear', as: 'clear'
  #


end
