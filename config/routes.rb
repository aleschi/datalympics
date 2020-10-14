Rails.application.routes.draw do

  resources :ouvrages_financements do 
    collection {post :import}
  end
  resources :ouvrages_depenses do 
    collection do 
      post 'import' => 'ouvrages_depenses#import'
      post 'import2' => 'ouvrages_depenses#import2'
      post 'import3' => 'ouvrages_depenses#import3'
    end
  end 
  resources :solideo_depenses
  resources :solideo_financements do 
    collection do 
      post 'import' => 'solideo_financements#import'
      post 'import2' => 'solideo_financements#import2'
      post 'deleteall' => 'solideo_financements#delete_financements'
    end 
    
  end 
  resources :etat_budgets
  resources :etat_depenses
  resources :ouvrages do 
    collection {post :import}
  end 
  root 'pages#home'
  
  get 'etat_depenses_filter' => 'etat_depenses#index_filter'
  get 'solideo_financements_filter' => 'solideo_financements#index_filter'
  
  get 'collectivites' => 'solideo_financements#collectivites'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
