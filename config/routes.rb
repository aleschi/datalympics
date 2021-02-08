Rails.application.routes.draw do

  resources :chorus do 
    collection do 
      post 'import' => 'chorus#import'
    end
  end 
  resources :chantiers
  devise_for :users, :path => "",
    :path_names =>  {:sign_in => "connexion", :sign_out => "deconnexion"}
  ActiveAdmin.routes(self)
  resources :ouvrages_financements do 
    collection {post :import}
  end
  resources :ouvrages_depenses do 
    collection do 
      post 'import' => 'ouvrages_depenses#import'
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
  resources :ouvrages_revues
  resources :etat_budgets
  resources :etat_depenses do 
    collection do 
      post 'import' => 'etat_depenses#import'
    end 
  end
  resources :ouvrages do 
    collection {post :import}
  end 
  resources :documents
  root 'pages#home'
  get 'documents-etat' => 'documents#documents_etat'
  
  get 'documents-solideo' => 'documents#documents_solideo'
  get 'etat-budget-solideo' => "etat_budgets#budget_solideo"
  get 'etat-budget-cojo' => "etat_budgets#budget_cojo"
  
  get 'etat_depenses_filter' => 'etat_depenses#index_filter'
  get 'solideo_financements_filter' => 'solideo_financements#index_filter'
  
  get 'collectivites' => 'solideo_financements#collectivites'
  get 'recherche-ouvrages' => 'ouvrages#search'
  post 'delete-document' => 'documents#delete_file'
  
  get 'timeline' => 'ouvrages#timeline'
  post 'select_bop' => 'chorus#select_bop'
  post 'select_uo' => 'chorus#select_uo'
   post 'select_date_programme' => 'chorus#select_date_programme'
  post 'select_action' => 'chorus#select_action'
  
  post 'import_maquette' => "ouvrages_depenses#import_maquette"
  get 'maquette' => 'ouvrages_depenses#maquette'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
