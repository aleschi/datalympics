ActiveAdmin.register Maquette do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :name, :ouvrage_id, :total, :total_complementaire, :total_public, :date, :commentaire
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :ouvrage_id, :total, :total_complementaire, :total_public, :date, :commentaire]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
