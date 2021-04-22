class SolideoDepensesController < ApplicationController
  before_action :set_solideo_depense, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /solideo_depenses
  # GET /solideo_depenses.json
  def index
     @nav=true

    @dates_ouvrages_reporting = Chantier.pluck(:date).uniq!
    
    @budget_ouvrages = Maquette.where('date = ?',Date.new(2021,1,14)).where.not(ouvrage_id: nil).sum('total') 
    @budget_fonctionnement = Maquette.where('date = ? AND name = ?',Date.new(2021,1,14), "Frais de Structure SOLIDEO").sum('total') 
    @budget_innovation = Maquette.where('date = ? AND (name = ? OR name = ?)',Date.new(2021,1,14), "Fonds Innovation et Développement Durable", "Paris Fonds Vert").sum('total') 
    @budget_reserve = Maquette.where(ouvrage_id: nil).where('date = ? AND name != ? AND name != ? AND name != ?',Date.new(2021,1,14),"Frais de Structure SOLIDEO", "Fonds Innovation et Développement Durable", "Paris Fonds Vert").sum('total') 
    
    @solideo_depenses = SolideoDepense.all
    @solideo_financements = SolideoFinancement.all
    #fonctionnement
    @fonctionnement_a =  @solideo_depenses.unscope(:order).group_by_year(:date).sum('fonctionnement')    
    @depenses_annee_fonctionnement = []
    (2018..2020).each do |annee|    
      @is_present = false 
       @fonctionnement_a.each do |h|
        if h[0].year == annee
          @depenses_annee_fonctionnement << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_annee_fonctionnement << 0
      end
    end
    
    #innovation  
    @innovation_a =  @solideo_financements.where('categorie = ?', "innovation").unscope(:order).group_by_year(:date).sum('montant')    
    @depenses_annee_innovation = []
    (2018..2020).each do |annee|      
       @innovation_a.each do |h|
        if h[0].year == annee
          @depenses_annee_innovation << (h[1]/1000).round          
        end 
      end     
    end
    
    #reserve
    @reserve_a =  @solideo_financements.where('categorie = ? AND date <= ?', "reserve", Date.today).unscope(:order).group_by_year(:date).sum('montant')    
    @depenses_annee_reserve = []
    (2018..2020).each do |annee|    
       @reserve_a.each do |h|
        if h[0].year == annee
          @depenses_annee_reserve << (h[1]/1000).round  
        end 
      end
    end
    

  end

  # GET /solideo_depenses/1
  # GET /solideo_depenses/1.json
  def show
  end

  # GET /solideo_depenses/new
  def new
    @solideo_depense = SolideoDepense.new
  end

  # GET /solideo_depenses/1/edit
  def edit
  end

  # POST /solideo_depenses
  # POST /solideo_depenses.json
  def create
    @solideo_depense = SolideoDepense.new(solideo_depense_params)

    respond_to do |format|
      if @solideo_depense.save
        format.html { redirect_to solideo_depenses_path, notice: 'Solideo depense was successfully created.' }
        format.json { render :show, status: :created, location: @solideo_depense }
      else
        format.html { render :new }
        format.json { render json: @solideo_depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solideo_depenses/1
  # PATCH/PUT /solideo_depenses/1.json
  def update
    respond_to do |format|
      if @solideo_depense.update(solideo_depense_params)
        format.html { redirect_to solideo_depenses_path, notice: 'Solideo depense was successfully updated.' }
        format.json { render :show, status: :ok, location: @solideo_depense }
      else
        format.html { render :edit }
        format.json { render json: @solideo_depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solideo_depenses/1
  # DELETE /solideo_depenses/1.json
  def destroy
    @solideo_depense.destroy
    respond_to do |format|
      format.html { redirect_to solideo_depenses_url, notice: 'Solideo depense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solideo_depense
      @solideo_depense = SolideoDepense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def solideo_depense_params
      params.require(:solideo_depense).permit(:date, :ouvrages, :reserve, :fonctionnement, :innovation)
    end
end
