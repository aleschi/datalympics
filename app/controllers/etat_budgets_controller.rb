class EtatBudgetsController < ApplicationController
  before_action :set_etat_budget, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /etat_budgets
  # GET /etat_budgets.json
  def index
    @nav=true
    @etat_budgets = EtatBudget.all
    if !EtatBudget.last.nil?
      @etat_budget_actuel = EtatBudget.last
    end
    if !EtatBudget.first.nil?
      @etat_budget_first = EtatBudget.first
    end
    
    @etat_depenses = EtatDepense.all
    @etat_depenses_hash = EtatDepense.all.order('date DESC').group(:date).sum('cp_conso')
    @etat_depenses_array = []
    @etat_depenses_hash.each do |h|
      @etat_depenses_array << h[0]
    end 
 
    @etat_depenses_solideo = EtatDepense.where("beneficiaire =?", "solideo").sum('cp_conso') 
    @etat_depenses_cojo = EtatDepense.where("beneficiaire =?", "cojo").sum('cp_conso')  
    @etat_depenses_heritage = EtatDepense.where("beneficiaire =?", "heritage").sum('cp_conso')
    @etat_depenses_hauteperformance = EtatDepense.where("beneficiaire =?", "hauteperformance").sum('cp_conso')

    @ouvrages= Ouvrage.where("maitre_oeuvre = ? ", 'Etat')
    @ouvrages_etat=[]
    OuvragesFinancement.where('name = ?', "Etat").each do |financement|
      if Ouvrage.find(financement.ouvrage_id).maitre_oeuvre != "Etat"
      @ouvrages_etat << financement.ouvrage_id 
      end 
    end
    @ouvrages_etat.uniq!

    @programme = Choru.where('type_ae = ? AND centre_financier = ? AND date >= ? AND date < ? AND compte_budgetaire = ?','cp', '350', Date.new(2020,1,1), Date.new(2020,12,31), 'HT2').order('date ASC')
    @bop = Choru.where('type_ae = ? AND centre_financier = ? AND date >= ? AND date < ? AND compte_budgetaire = ?','cp', '0350-CDSP',Date.new(2020,1,1), Date.new(2020,12,31), 'HT2').order('date ASC')
    @uo = Choru.where('type_ae = ? AND centre_financier = ? AND date >= ? AND date < ? AND compte_budgetaire = ?','cp', '0350-CDSP-CDSP',Date.new(2020,1,1), Date.new(2020,12,31), 'HT2').order('date ASC')
    @conso = Choru.where('centre_financier = ? AND date >= ? AND date <= ? AND type_ae = ? AND (compte_budgetaire != ? AND compte_budgetaire != ? AND compte_budgetaire != ? AND compte_budgetaire != ? AND compte_budgetaire != ? AND compte_budgetaire != ?)', '0350-CDSP-CDSP',Date.new(2020,1,1), Date.new(2020,12,31), 'cp', "21","22","23","24","25","26").where.not(domaine_fonctionnel: nil).order('date ASC')

    @montant_lfi = @programme.where('type_budget = ? OR type_budget = ?', "Bud. voté ou en cours de vote", "Loi de Finances Initiale").first.montant   
    @montant_dispo = @programme.where('type_piece != ? AND type_piece != ?',"MADI",'RB').sum('montant')
    @montant_reserve = @programme.where('type_piece = ?','RB').sum('montant')
    @montant_conso = @conso.sum('montant')
       
  end

  # GET /etat_budgets/1
  # GET /etat_budgets/1.json
  def show
  end

  # GET /etat_budgets/new
  def new
    @etat_budget = EtatBudget.new
  end

  # GET /etat_budgets/1/edit
  def edit
  end

  # POST /etat_budgets
  # POST /etat_budgets.json
  def create
    @etat_budget = EtatBudget.new(etat_budget_params)

    respond_to do |format|
      if @etat_budget.save
        format.html { redirect_to etat_budgets_path, notice: 'Etat budget was successfully created.' }
        format.json { render :show, status: :created, location: @etat_budget }
      else
        format.html { render :new }
        format.json { render json: @etat_budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etat_budgets/1
  # PATCH/PUT /etat_budgets/1.json
  def update
    respond_to do |format|
      if @etat_budget.update(etat_budget_params)
        format.html { redirect_to @etat_budget, notice: 'Etat budget was successfully updated.' }
        format.json { render :show, status: :ok, location: @etat_budget }
      else
        format.html { render :edit }
        format.json { render json: @etat_budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etat_budgets/1
  # DELETE /etat_budgets/1.json
  def destroy
    @etat_budget.destroy
    respond_to do |format|
      format.html { redirect_to etat_budgets_url, notice: 'Etat budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def budget_solideo
    @nav=true
  
    @etat_depenses = EtatDepense.where("beneficiaire =?", "solideo").order('date DESC')
    
    @cp_c =  @etat_depenses.unscope(:order).group_by_year(:date).sum(:cp_conso) 
    @cp_p =  @etat_depenses.unscope(:order).group_by_year(:date).sum(:cp_prevu)
    
     @cp_annee = []
    @cp_prevu_annee= []
    (2018..2019).each do |annee|    
      @is_present = false 
       @cp_c.each do |h|
        if h[0].year == annee
          @cp_annee << (h[1]/1000).round
          @is_present = true 
        end 
      end
      if @is_present == false 
         @cp_annee << 0
      end
    end
    (2018..2021).each do |annee|    
      @is_present = false 
       @cp_p.each do |h|
        if h[0].year == annee
          @cp_prevu_annee << (h[1]/1000).round
          @is_present = true 
        end 
      end
      if @is_present == false 
         @cp_prevu_annee << 0
      end
    end
    
    @ae_c =  @etat_depenses.unscope(:order).group_by_year(:date).sum(:ae_conso) 
    @ae_p =  @etat_depenses.unscope(:order).group_by_year(:date).sum(:ae_prevu)
    
     @ae_annee = []
    @ae_prevu_annee= []
    (2018..2019).each do |annee|    
      @is_present = false 
       @ae_c.each do |h|
        if h[0].year == annee
          @ae_annee << (h[1]/1000).round
          @is_present = true 
        end 
      end
      if @is_present == false 
         @ae_annee << 0
      end
    end
    (2018..2021).each do |annee|    
      @is_present = false 
       @ae_p.each do |h|
        if h[0].year == annee
          @ae_prevu_annee << (h[1]/1000).round
          @is_present = true 
        end 
      end
      if @is_present == false 
         @ae_prevu_annee << 0
      end
    end
  end
  
  def budget_cojo
    @nav=true
    @etat_depenses = EtatDepense.where("beneficiaire =?", "cojo").order('date DESC')
 
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etat_budget
      @etat_budget = EtatBudget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def etat_budget_params
      params.require(:etat_budget).permit(:date, :budget_total, :budget_solideo, :budget_cojo, :budget_heritage, :budget_hauteperformance)
    end
end
