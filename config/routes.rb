Rails.application.routes.draw do


  resources :ligne_factures
  get 'report/index'
  resources :clients
  resources :produits do
    collection { post :import }
  end
  resources :users
  resources :factures
  put 'valider/:id', to: 'factures#valider', as: 'validation'

  root to: 'login#home'

  # Reporting
  get 'reporting', to: 'report#index', as: 'report'

  # Gestion de l'authentification
  get 'login', to: 'login#login', as: 'login'
  post 'login', to: 'login#connect'
  get 'logout', to: 'login#disconnect', as:'logout'


  # error handling
  get '403', to: 'login#login', as: 'forbiden'
  get '404', to: 'login#login', as: 'notfound'
  # API
  get 'api/factures', to: 'factures#api'



  # for test
  get 'test/putSession', to: 'login#put', as: 'put'
  get 'test/testSession', to: 'login#setSession', as: 'setsession'
  get 'test/clearSession', to: 'login#clear', as: 'clear'
  #


end
