ActiveAdmin.register Choru do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :date, :type_piece, :type_budget, :operation, :centre_financier, :compte_budgetaire, :montant, :domaine_fonctionnel, :type_ae
  #
  # or
  #

  # permit_params do
  #   permitted = [:date, :type_piece, :type_budget, :operation, :centre_financier, :compte_budgetaire, :montant, :domaine_fonctionnel, :type_ae]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
