ActiveAdmin.register EtatDepense do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :date, :beneficiaire, :titre, :categorie, :ae_prevu, :ae_conso, :cp_prevu, :cp_conso
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :beneficiaire, :titre, :categorie, :ae_prevu, :ae_conso, :cp_prevu, :cp_conso]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
