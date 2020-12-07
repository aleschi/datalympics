class OuvragesRevuesController < ApplicationController
  before_action :authenticate_user!
  def new 
   
     @ouvrages_revue = OuvragesRevue.new
    @ouvrage = Ouvrage.find(params[:ouvrage_id])
  end 
  def create 
    @ouvrages_revue = OuvragesRevue.new(ouvrages_revue_params)

    respond_to do |format|
      if @ouvrages_revue.save
        format.html { redirect_to ouvrages_revues_path, notice: 'Revue ajoutée' }
      else
        format.html { render :new }
      end
    end
  end 
  
  def index
     @nav= true 
    @ouvrages = Ouvrage.all 
  end 
   private
 
    # Only allow a list of trusted parameters through.
    def ouvrages_revue_params
      params.require(:ouvrages_revue).permit(:date, :delai_commentaire, :delai_action, :delai_time, :budget_indicateur, :budget_commentaire, :budget_action, :ouvrage_id)
    end
end