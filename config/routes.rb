Rails.application.routes.draw do
  resources :ouvrages_financeurs do 
    collection {post :import}
  end
  resources :ouvrages_financements do 
    collection {post :import}
  end
  resources :ouvrages_depenses
  resources :solideo_depenses
  resources :solideo_financements do 
    collection {post :import}
  end 
  resources :etat_budgets
  resources :etat_depenses
  resources :ouvrages do 
    collection {post :import}
  end 
  root 'pages#home'
  
  get 'etat_depenses_filter' => 'etat_depenses#index_filter'
  
  get 'collectivites' => 'solideo_financements#collectivites'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
