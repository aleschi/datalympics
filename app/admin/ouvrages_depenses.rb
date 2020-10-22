ActiveAdmin.register OuvragesDepense do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :date, :ouvrage_id, :name, :montant, :montant_engage, :montant_prevu, :date_maquette
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :ouvrage_id, :name, :montant, :montant_engage, :montant_prevu]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
