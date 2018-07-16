Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'mon_espace', to: "pages#mon_espace"
  get 'admin_dashboard', to: "pages#admin_dashboard"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  get 'location', to: "pages#location"
  get 'vente', to: "pages#vente"
  get 'reparation', to: "pages#reparation"
  get 'contact', to: "pages#contact"
  get 'minilease', to: "pages#minilease"
  get 'garantie_dommages', to: "pages#garantie_dommages"
  get 'conditions_generales_de_location', to: "pages#conditions_generales_de_location"
  get 'conditions_generales_de_vente', to: "pages#conditions_generales_de_vente"
  get 'documentations', to: "pages#documentations"

  get ':name/products', to: "categories#show", as: "category_products"

  resources :categories, only: [ :create, :update, :destroy ]
  resources :products, only: [ :show, :create, :update, :destroy ] do
    resources :expendables, only: [ :create, :update, :destroy ]
  end
  resources :promos
  resources :messages, only: [ :show, :create, :destroy ] do
    post '/check', to: 'messages#check!'
    post '/uncheck', to: 'messages#uncheck!'
  end

  resources :invoices
  post 'synchronization', to: "pages#synchronization"

  resources :catalogs, only: [ :create, :update ]
end
