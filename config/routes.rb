Rails.application.routes.draw do
  
  resources :innovations
  resources :chorus do 
    collection do 
      post 'import' => 'chorus#import'
     
    end
  end 
 
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
  resources :solideo_depenses do 
    collection do 
      post 'import_structure' => 'solideo_depenses#import_structure'
      post 'import_depenses' => 'solideo_depenses#import_depenses'
    end 
  end
  resources :solideo_financements do 
    collection do 
      post 'import' => 'solideo_financements#import'
      post 'import2' => 'solideo_financements#import2'
      post 'deleteall' => 'solideo_financements#delete_financements'
      post 'import_financeur' => 'solideo_financements#import_financeur'
      post 'import_financements' => 'solideo_financements#import_financements'
    end 
    
  end 

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

  resources :innovations do 
    collection do 
      post 'import' => 'innovations#import'
      post 'import2' => 'innovations#import2'
      post 'import_categorie' => 'innovations#import_categorie'
    end 
  end
  get '/new-versement'=>'innovations#new_versement'
  get '/new-categorie'=>'innovations#new_categorie'
  root 'pages#home'
  
  get 'documents-solideo' => 'documents#documents_solideo'

  get 'new_structure' => 'solideo_depenses#new_structure'
  get 'new_financeur' => 'solideo_financements#new_financeur'
  
  get 'etat_depenses_filter' => 'etat_depenses#index_filter'
  get 'solideo_financements_filter' => 'solideo_financements#index_filter'
  
  
  get 'recherche-ouvrages' => 'ouvrages#search'
  get 'recherche-projets' => 'innovations#search'
  post 'delete-document' => 'documents#delete_file'
  
  get 'timeline' => 'ouvrages#timeline'
  get 'risques' => 'ouvrages#risques'
  post 'select_bop' => 'chorus#select_bop'
  post 'select_uo' => 'chorus#select_uo'
   post 'select_date_programme' => 'chorus#select_date_programme'
  post 'select_action' => 'chorus#select_action'
  get 'new_nom' => 'chorus#new_nom'
   post 'import_nom' => 'chorus#import_nom'
  get 'search_choru' => "chorus#search_choru"
  
  post 'import_maquette' => "ouvrages_depenses#import_maquette"

  
  post 'update_file' => 'ouvrages#update_file'
  get 'les-jop2024' => 'pages#jop2024'
  get 'synthese' => "pages#synthese"
  get 'reporting' => "pages#reporting"

  get 'mentions-legales' => "pages#mentions"
  get 'accessibilite' => "pages#accessibilite"
  get 'public' => "pages#public"
  get 'utilisation-budget' => 'pages#interets'
  get 'impacts' => 'pages#impacts'
  post 'maquette-date' => 'ouvrages_depenses#maquette_date'

  post 'form-edit' => 'innovations#form_edit'

  post 'import_disciplines' => "pages#import_disciplines"
  get 'new-disciplines' => "pages#new_disciplines"
  post 'import_ouvrages_publics' => "pages#import_ouvrages_publics"
  get 'new-ouvrages-publics' => "pages#new_ouvrages_publics"

  get 'recherche-ouvrages-publics' => 'pages#search_ouvrages_publics'

  post 'supp' => 'chorus#supp'
  post 'sort_table_programme' => "chorus#sort_table_programme"

  match "/404" => "errors#error404", via: [:get, :post, :patch, :delete]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
