class ChantiersController < ApplicationController
  before_action :set_chantier, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @nav = true
  end
  
  def show
    @nav = true
    @navshow = true 
    @ouvrage = @chantier.ouvrage 
  end 
  
  def new 
  end 
  
  def edit 
  end 
  
  def update
  end
  
  def destroy
  end 
  def import
    Chantier.import(params[:file], params[:date])
    redirect_to solideo_depenses_path 
  end 
  private
  
  def set_chantier
      @chantier = Chantier.find(params[:id])
    end

    def chantier_params
      params.require(:chantier).permit(:name, :ouvrage_id, :code, :site, :libelle, :typecontrat, :datesignature, :total_depenses_actees, :depenses_actees_annee, :jalons_annee, :paiements_annee, :paiements_attente_annee, :budget_annee, :cumul_depenses_actees, :cumul_jalons, :cumul_paiements, :date)
    end

end
