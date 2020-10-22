ActiveAdmin.register Ouvrage do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :name, :maitre_oeuvre, :budget, :adresse
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :maitre_oeuvre, :budget, :adresse]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
