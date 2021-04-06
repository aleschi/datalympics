ActiveAdmin.register OuvragesRevue do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :date, :ouvrage_id, :delai_commentaire, :delai_action, :delai_time, :budget_indicateur, :budget_commentaire, :budget_action, :delai_indicateur, :date_maj
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :ouvrage_id, :delai_commentaire, :delai_action, :delai_time, :budget_indicateur, :budget_commentaire, :budget_action, :delai_indicateur, :date_maj]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
