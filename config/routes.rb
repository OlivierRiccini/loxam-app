Rails.application.routes.draw do
  devise_for :users
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

  resources :product
  resources :user do
    get 'mon_espace', to: "users#show"
    resources :document
  end

  resources :promo
end
