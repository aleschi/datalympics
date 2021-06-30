class SolideoFinancementsController < ApplicationController
  before_action :set_solideo_financement, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /solideo_financements
  # GET /solideo_financements.json
  def index
     @nav=true
     @dates_maquettes= Maquette.order('date DESC').pluck(:date).uniq! 
    @solideo_financements = SolideoFinancement.all
    @financeurs = ["privé", "Etat", "RIF", "Ville de Paris", "Métropole Grand Paris", "CD92", "CD93", "CD78", "EPT Plaine Commune","EPT Terres d'envol", "Ville de Dugny", "Ville du Bourget", "CASQY", "Ville de Marseille"]

    @solideo_financements_etat = SolideoFinancement.where("financeur = ? AND date = ?", "Etat", SolideoFinancement.last.date).sum('montant')
    @solideo_financements_prive = SolideoFinancement.where("financeur = ? AND date = ?", "privé", SolideoFinancement.last.date).sum('montant')
    @solideo_financements_collectivites = SolideoFinancement.where("financeur != ? AND financeur != ? AND date = ?", "Etat", "privé", SolideoFinancement.last.date).sum('montant')
    
    @dates_reporting = [Date.new(2020,1,1),Date.new(2019,1,1),Date.new(2018,1,1)]
   
  end
  
  def index_filter
     respond_to do |format|
      format.js
    end
  end 

  # GET /solideo_financements/1
  # GET /solideo_financements/1.json
  def show
  end 

  # GET /solideo_financements/new
  def new
    @solideo_financement = SolideoFinancement.new
  end

  # GET /solideo_financements/1/edit
  def edit
  end
  
  def import
    SolideoFinancement.import(params[:file])
    redirect_to solideo_financements_path  
  end
  def import2
    SolideoFinancement.import2(params[:file], params[:date_year].to_i, params[:date_month].to_i)
    OuvragesFinancement.import_ouvrage2(params[:file], params[:date_year].to_i, params[:date_month].to_i)
    redirect_to solideo_financements_path    
  end
  
  def delete_financements
    @solideo_financements = SolideoFinancement.where('date = ?', params[:date])
    @solideo_financements.all.destroy_all
    @ouvrages_financements = OuvragesFinancement.where('date = ? ', params[:date])
    @ouvrages_financements.all.destroy_all
    redirect_to new_solideo_financement_path 
  end  
  

  # POST /solideo_financements
  # POST /solideo_financements.json
  def create
    @solideo_financement = SolideoFinancement.new(solideo_financement_params)

    respond_to do |format|
      if @solideo_financement.save
        format.html { redirect_to @solideo_financement, notice: 'Solideo financement was successfully created.' }
        format.json { render :show, status: :created, location: @solideo_financement }
      else
        format.html { render :new }
        format.json { render json: @solideo_financement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solideo_financements/1
  # PATCH/PUT /solideo_financements/1.json
  def update
    respond_to do |format|
      if @solideo_financement.update(solideo_financement_params)
        format.html { redirect_to @solideo_financement, notice: 'Solideo financement was successfully updated.' }
        format.json { render :show, status: :ok, location: @solideo_financement }
      else
        format.html { render :edit }
        format.json { render json: @solideo_financement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solideo_financements/1
  # DELETE /solideo_financements/1.json
  def destroy
    @solideo_financement.destroy
    respond_to do |format|
      format.html { redirect_to solideo_financements_url, notice: 'Solideo financement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solideo_financement
      @solideo_financement = SolideoFinancement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def solideo_financement_params
      params.require(:solideo_financement).permit(:financeur, :date, :montant_prevu, :montant, :categorie)
    end
end
