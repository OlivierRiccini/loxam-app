Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :documents
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

  get ':name/products', to: "categories#show", as: "category"

  resources :categories, only: [ :new, :create, :edit, :update, :destroy]
  resources :products
  resources :promos
  resources :messages, only: [ :show, :create, :edit, :destroy ]
end
