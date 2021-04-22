class SolideoDepensesController < ApplicationController
  before_action :set_solideo_depense, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /solideo_depenses
  # GET /solideo_depenses.json
  def index
     @nav=true

    @dates_ouvrages_reporting = Chantier.pluck(:date).uniq!
    
    @dates_maquettes= Maquette.order('date DESC').pluck(:date).uniq! 

    @budget_ouvrages = (Maquette.where('date = ?',@dates_maquettes[@dates_maquettes.length-1]).where.not(ouvrage_id: nil).sum('total')/1000000).to_i 
    @budget_ouvrages_depenses = (Chantier.where('date = ?',@dates_ouvrages_reporting[@dates_ouvrages_reporting.length-1]).sum('cumul_paiements')/1000000).to_i

    @budget_fonctionnement = (Maquette.where('date = ? AND name = ?',@dates_maquettes[@dates_maquettes.length-1], "Frais de Structure SOLIDEO").sum('total')/1000000).to_i 
    
    @budget_innovation_initial = (Maquette.where('date = ? AND (name = ? OR name = ?)',@dates_maquettes[@dates_maquettes.length-1], "Fonds Innovation et Développement Durable", "Paris Fonds Vert").sum('total')/1000000).to_i
    @budget_innovation_consomme = ((Maquette.where('date = ? AND (name = ? OR name = ?)',@dates_maquettes[@dates_maquettes.length-1], "Fonds Innovation et Développement Durable", "Paris Fonds Vert").sum('total')-Maquette.where('date = ? AND (name = ? OR name = ?)',@dates_maquettes[0], "Fonds Innovation et Développement Durable", "Paris Fonds Vert").sum('total'))/1000000).to_i
    
    @budget_reserve_initial = (Maquette.where('date = ? AND (name = ? OR name = ? OR name = ? OR name = ?)',@dates_maquettes[@dates_maquettes.length-1], "Réserve pour compléments de programme", "CPJ","Voies Olympiques [Réserve]", "Stade de France [Pertes d'exploitation]").sum('total')/1000000).to_i 
    @budget_reserve_consomme = ((Maquette.where('date = ? AND (name = ? OR name = ? OR name = ? OR name = ?)',@dates_maquettes[@dates_maquettes.length-1], "Réserve pour compléments de programme", "CPJ","Voies Olympiques [Réserve]", "Stade de France [Pertes d'exploitation]").sum('total') - Maquette.where('date = ? AND (name = ? OR name = ? OR name = ? OR name = ?)',@dates_maquettes[0], "Réserve pour compléments de programme", "CPJ","Voies Olympiques [Réserve]", "Stade de France [Pertes d'exploitation]").sum('total'))/1000000).to_i 

    @solideo_depenses = SolideoDepense.all
    @solideo_financements = SolideoFinancement.all
    #fonctionnement
    @fonctionnement_a =  @solideo_depenses.unscope(:order).group_by_year(:date).sum('fonctionnement')    
    @depenses_annee_fonctionnement = []
    (2018..2020).each do |annee|    
      @is_present = false 
       @fonctionnement_a.each do |h|
        if h[0].year == annee
          @depenses_annee_fonctionnement << h[1]/1000
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_annee_fonctionnement << 0
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
