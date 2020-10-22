ActiveAdmin.register SolideoFinancement do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :financeur, :date, :montant_prevu, :montant, :categorie
  #
  # or
  #
  # permit_params do
  #   permitted = [:financeur, :date, :montant_prevu, :montant, :categorie]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
