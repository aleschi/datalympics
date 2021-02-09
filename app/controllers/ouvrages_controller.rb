class OuvragesController < ApplicationController
  before_action :set_ouvrage, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  require 'csv'
  # GET /ouvrages
  # GET /ouvrages.json
  def index
     @nav=true
    @q = Ouvrage.all.ransack(params[:q])
   
    @ouvrages = Ouvrage.all
    @ouvrages_financements = OuvragesFinancement.all
    @ouvrages_depenses = OuvragesDepense.all
    @financeurs = ["privé", "Etat", "RIF", "Ville de Paris", "Métropole Grand Paris", "CD92", "CD93", "CD78", "EPT Plaine Commune","EPT Terres d'envol", "Ville de Dugny", "Ville du Bourget", "CASQY", "Ville de Marseille"]

    @maitre_oeuvre = []
    @maitre_oeuvre_all = []
    @array= []
    @ouvrages.all.each do |ouvrage|
      if ouvrage.maitre_oeuvre != "SOLIDEO"
      @maitre_oeuvre << ouvrage.maitre_oeuvre
      end
      @maitre_oeuvre_all << ouvrage.maitre_oeuvre
      @array << ouvrage.name
    end
    @maitre_oeuvre.uniq!
    @maitre_oeuvre_all.uniq!
    
    
    @solideo_depenses_ouvrages_prevu = OuvragesDepense.all.unscope(:order).group(:date).sum('montant_prevu')
    @solideo_depenses_ouvrages_reel = OuvragesDepense.all.unscope(:order).group(:date).sum('montant')    
    
    @solideo_depenses_ouvrages = OuvragesDepense.all.sum('montant')
    @solideo_depenses_ouvrages_prevu_date = OuvragesDepense.where('date <= ?', Date.today).sum('montant_prevu')
    
    if params[:term]
        @ouvrages = Ouvrage.where('name like ?', "%#{params[:term]}%")
        
        render json: @ouvrages.map(&:name)  
      end
    
    @h_depenses = OuvragesDepense.all.unscope(:order).group(:date).sum('montant')
    @h_depenses_prevu = OuvragesDepense.all.unscope(:order).group(:date).sum('montant_prevu')
    @depenses = []
    @depenses_prevu = []
    (1..32).each do |n|    
      @is_present = false 
      @h_depenses.each do |h|
        if h[0] == Date.new(2018) + (n*3 - 1).months
          @depenses << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses << 0
      end
    end
    (1..32).each do |n|    
      @is_present = false 
      @h_depenses_prevu.each do |h|
        if h[0] == Date.new(2018)+ (n*3 - 1).months
          @depenses_prevu << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_prevu << 0
      end
    end
  end
  
  def search 
    @ouvrages = Ouvrage.all
    @q = @ouvrages.ransack(params[:q])
    @ouvrages = @q.result
    
    @maitre_oeuvre = []
    @maitre_oeuvre_all = []
    @array= []
    @ouvrages.all.each do |ouvrage|
      if ouvrage.maitre_oeuvre != "SOLIDEO"
      @maitre_oeuvre << ouvrage.maitre_oeuvre
      end
      @maitre_oeuvre_all << ouvrage.maitre_oeuvre
      @array << ouvrage.name
    end
    @maitre_oeuvre.uniq!
    @maitre_oeuvre_all.uniq!
    
    respond_to do |format|

     format.js

    end
  end 

  # GET /ouvrages/1
  # GET /ouvrages/1.json
  def show
    @navshow = true 
    @nav=true
    @ouvrage_financements = OuvragesFinancement.all.where('ouvrage_id = ?', @ouvrage.id)
    @ouvrage_depenses = OuvragesDepense.all.where('ouvrage_id = ?', @ouvrage.id)
 
    @ouvrage_financeurs = []
    @ouvrage_financements.each do |financement|
      @ouvrage_financeurs << financement.name 
    end
    @ouvrage_financeurs = @ouvrage_financeurs.uniq!
    
    
  end

  # GET /ouvrages/new
  def new
    @ouvrage = Ouvrage.new
  end

  # GET /ouvrages/1/edit
  def edit
  end


  def import
    Ouvrage.import(params[:file])
    redirect_to ouvrages_path
    
  end 
  def update_file
    Ouvrage.update_file(params[:file])
    redirect_to ouvrages_path
  end 
  
  # POST /ouvrages
  # POST /ouvrages.json
  def create 
    @ouvrage = Ouvrage.new(ouvrage_params)

    respond_to do |format|
      if @ouvrage.save
        format.html { redirect_to @ouvrage, notice: 'Ouvrage was successfully created.' }
        format.json { render :show, status: :created, location: @ouvrage }
      else
        format.html { render :new }
        format.json { render json: @ouvrage.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /ouvrages/1
  # PATCH/PUT /ouvrages/1.json
  def update
    respond_to do |format|
      if @ouvrage.update(ouvrage_params)
        format.html { redirect_to @ouvrage, notice: 'Ouvrage was successfully updated.' }
        format.json { render :show, status: :ok, location: @ouvrage }
      else
        format.html { render :edit }
        format.json { render json: @ouvrage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ouvrages/1
  # DELETE /ouvrages/1.json
  def destroy
    @ouvrage = Ouvrage.find(params[:id])
    @ouvrage.destroy
    respond_to do |format|
      format.html { redirect_to ouvrages_url, notice: 'Ouvrage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def timeline
    @nav=true 
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ouvrage
      @ouvrage = Ouvrage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ouvrage_params
      params.require(:ouvrage).permit(:name, :adresse, :maitre_oeuvre, :budget ,:photo, :description, :phase_jo, :heritage, :start, :end, :date)
    end
end
