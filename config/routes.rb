Rails.application.routes.draw do
  resources :etat_budgets
  resources :etat_depenses
  resources :ouvrages do 
    collection {post :import}
  end 
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
