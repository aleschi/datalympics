class SolideoFinancementsController < ApplicationController
  before_action :set_solideo_financement, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /solideo_financements
  # GET /solideo_financements.json
  def index
     @nav=true
    @solideo_financements = SolideoFinancement.all
 
    @solideo_financements_etat_prevu = SolideoFinancement.where("financeur = ? ", "Etat").sum('montant_prevu')
    @solideo_financements_etat_prevu_date = SolideoFinancement.where("financeur = ? AND date <= ? ", "Etat", Date.today).sum('montant_prevu')
    @solideo_financements_etat = SolideoFinancement.where("financeur = ? ", "Etat").sum('montant')
    @solideo_financements_prive_prevu = SolideoFinancement.where("financeur = ? ", "privé").sum('montant_prevu')   
    @solideo_financements_prive_prevu_date = SolideoFinancement.where("financeur = ? AND date <= ?", "privé", Date.today).sum('montant_prevu')
    @solideo_financements_prive = SolideoFinancement.where("financeur = ? ", "privé").sum('montant')
    @solideo_financements_collectivites_prevu = SolideoFinancement.where("financeur != ? AND financeur != ?", "Etat", "privé").sum('montant_prevu')
    @solideo_financements_collectivites_prevu_date = SolideoFinancement.where("financeur != ? AND financeur != ? AND date <= ?", "Etat", "privé", Date.today).sum('montant_prevu')
    @solideo_financements_collectivites = SolideoFinancement.where("financeur != ? AND financeur != ?", "Etat", "privé").sum('montant')
    
    @solideo_financements_hash = SolideoFinancement.where('date <= ?', Date.today).order('date DESC').unscope(:order).group_by_year(:date).sum('montant')
    @solideo_financements_array = []
    
      @solideo_financements_hash.each do |h|
        if !h[0].nil?
        @solideo_financements_array << h[0]
        end
      end
    
    
    @financements_a =  @solideo_financements.unscope(:order).group_by_year(:date).sum('montant')    
    @financements_p =  @solideo_financements.unscope(:order).group_by_year(:date).sum('montant_prevu')
     @financements_annee = []
    @financements_prevu_annee= []
    (2018..2025).each do |annee|    
      @is_present = false 
       @financements_a.each do |h|
        if h[0].year == annee
          @financements_annee << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_annee << 0
      end
    end
    (2018..2025).each do |annee|    
      @is_present = false 
       @financements_p.each do |h|
        if h[0].year == annee
          @financements_prevu_annee << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_prevu_annee << 0
      end
    end
     #financements 
    @financements_etat = SolideoFinancement.where("financeur = ? ", "Etat").unscope(:order).group_by_year(:date).sum('montant')    
    @financements_etat_p = SolideoFinancement.where("financeur = ? ", "Etat").unscope(:order).group_by_year(:date).sum('montant_prevu')    
    @financements_collectivites =  SolideoFinancement.where("financeur != ? AND financeur != ?", "Etat", "privé").unscope(:order).group_by_year(:date).sum('montant') 
    @financements_collectivites_p =  SolideoFinancement.where("financeur != ? AND financeur != ?", "Etat", "privé").unscope(:order).group_by_year(:date).sum('montant_prevu')
     @financements_prives = SolideoFinancement.where("financeur = ? ", "privé").unscope(:order).group_by_year(:date).sum('montant') 
     @financements_annee_etat = []
    @financements_annee_etat_prevu = []
    @financements_annee_co= []
    @financements_annee_co_prevu= []
    @financements_annee_prive = []
    (2018..2025).each do |annee|    
      @is_present = false 
       @financements_etat.each do |h|
        if h[0].year == annee
          @financements_annee_etat << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_annee_etat << 0
      end
    end
     (2018..2025).each do |annee|    
      @is_present = false 
       @financements_etat_p.each do |h|
        if h[0].year == annee
          @financements_annee_etat_prevu << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_annee_etat_prevu << 0
      end
    end
    (2018..2025).each do |annee|    
      @is_present = false 
       @financements_collectivites.each do |h|
        if h[0].year == annee
          @financements_annee_co << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_annee_co << 0
      end
    end
    (2018..2025).each do |annee|    
      @is_present = false 
       @financements_collectivites_p.each do |h|
        if h[0].year == annee
          @financements_annee_co_prevu << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_annee_co_prevu << 0
      end
    end
    (2018..2025).each do |annee|    
      @is_present = false 
       @financements_prives.each do |h|
        if h[0].year == annee
          @financements_annee_prive << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_annee_prive << 0
      end
    end
  end
  
  def index_filter
     respond_to do |format|
      format.js
    end
  end 

  # GET /solideo_financements/1
  # GET /solideo_financements/1.json
  def show
     @nav=true
    @financement=SolideoFinancement.where('financeur = ?', @solideo_financement.financeur)
    @ouvrage_finances = OuvragesFinancement.where('name = ?', @solideo_financement.financeur)
    
    @ouvrages_hash = @ouvrage_finances.group(:ouvrage_id).sum('montant')
    @ouvrages = []
    
      @ouvrages_hash.each do |h|
        if !h[0].nil?
        @ouvrages << h[0]
        end 
      end
    @ouvrages_co=[]
    OuvragesFinancement.where('name = ?', @solideo_financement.financeur).each do |financement| 
      if Ouvrage.find(financement.ouvrage_id).maitre_oeuvre != @solideo_financement.financeur
      @ouvrages_co << financement.ouvrage_id 
      end 
    end
    @ouvrages_co.uniq!
  end 

  # GET /solideo_financements/new
  def new
    @solideo_financement = SolideoFinancement.new
  end

  # GET /solideo_financements/1/edit
  def edit
  end
  
  def import
    SolideoFinancement.import(params[:file], params[:date_year].to_i, params[:date_month].to_i)
    OuvragesFinancement.import_ouvrage(params[:file], params[:date_year].to_i, params[:date_month].to_i)
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
  
  def collectivites
     @nav=true
    @solideo_financements = SolideoFinancement.where('financeur != ? AND financeur != ? ', 'Etat', "privé").all
     @financeurs_hash = @solideo_financements.group(:financeur).sum('montant')
    @financeurs = []
    @financeurs_hash.each do |h|
      @financeurs << h[0]
    end
    
    
    @financements_collectivites =  SolideoFinancement.where("financeur != ? AND financeur != ?", "Etat", "privé").unscope(:order).group_by_year(:date).sum('montant') 
    @financements_collectivites_p =  SolideoFinancement.where("financeur != ? AND financeur != ?", "Etat", "privé").unscope(:order).group_by_year(:date).sum('montant_prevu')
    @financements_annee_co= []
    @financements_annee_co_prevu= []
        (2018..2025).each do |annee|    
      @is_present = false 
       @financements_collectivites.each do |h|
        if h[0].year == annee
          @financements_annee_co << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_annee_co << 0
      end
    end
    (2018..2025).each do |annee|    
      @is_present = false 
       @financements_collectivites_p.each do |h|
        if h[0].year == annee
          @financements_annee_co_prevu << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @financements_annee_co_prevu << 0
      end
    end
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
