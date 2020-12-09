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
  
  def edit 
    @ouvrages_revue = OuvragesRevue.find(params[:id])
    @ouvrage = @ouvrages_revue.ouvrage 
  end 
  
  def update 
    @ouvrages_revue = OuvragesRevue.find(params[:id])
    @ouvrage = @ouvrages_revue.ouvrage 
    params[:delai_time] = params[:delai_time].to_f
    respond_to do |format|
      if @ouvrages_revue.update(ouvrages_revue_params)
        format.html { redirect_to @ouvrage, notice: 'Ouvrage revue was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end 
  
   private
 
    # Only allow a list of trusted parameters through.
    def ouvrages_revue_params
      params.require(:ouvrages_revue).permit(:date, :delai_commentaire, :delai_action, :delai_time,:delai_indicateur, :budget_indicateur, :budget_commentaire, :budget_action, :ouvrage_id)
    end
end