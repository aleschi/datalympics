ActiveAdmin.register EtatBudget do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :date, :budget_total, :budget_solideo, :budget_cojo, :budget_heritage, :budget_hauteperformance
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :budget_total, :budget_solideo, :budget_cojo, :budget_heritage, :budget_hauteperformance]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
