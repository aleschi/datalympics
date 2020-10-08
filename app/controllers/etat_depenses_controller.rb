class EtatDepensesController < ApplicationController
  before_action :set_etat_depense, only: [:show, :edit, :update, :destroy]

  # GET /etat_depenses
  # GET /etat_depenses.json
  def index
    @etat_depenses = EtatDepense.all.order('date DESC')
    @etat_depenses_solideo = EtatDepense.where("beneficiaire =?", "solideo")
    @etat_depenses_cojo = EtatDepense.where("beneficiaire =?", "cojo")
    @etat_depenses_heritage = EtatDepense.where("beneficiaire =?", "heritage")
    @etat_depenses_hauteperformance = EtatDepense.where("beneficiaire =?", "hauteperformance")
    
  end
  
  def index_filter
  
    if params[:beneficiaires].nil?
      params[:beneficiaires] = ["solideo", "cojo", "hauteperformance", "heritage"]
    end 
    if params[:titres].nil?
      params[:titres]=['1','2','3','4','5','6','7']
    end 
    if params[:categories].nil?
      params[:categories]=['1','2','3','4','5']
    end 
    if params[:dates].nil?
      @dates=["2018","2019","2020","2021","2022","2023","2024","2025"]
    else
      @dates=params[:dates].to_a
    end 
    
    @etat_depenses= EtatDepense.where(beneficiaire: params[:beneficiaires], titre: params[:titres], categorie: params[:categories]).order('date DESC')
    
    @etat_depenses = @etat_depenses.to_a 
    
    @etat_depenses2 = []
    
    if !@etat_depenses.nil?
      @etat_depenses.each do |etat_depense|
       # if @dates.include?(etat_depense.date.year.to_s)
          @dates.each do |date|
             if etat_depense.date.year.to_s == date
               @etat_depenses2 << etat_depense
             end 
          end 
      end 
      
      @etat_depenses = @etat_depenses2
    end
    
    respond_to do |format|
      format.js
    end
  end 

  # GET /etat_depenses/1
  # GET /etat_depenses/1.json
  def show
  end

  # GET /etat_depenses/new
  def new
    @etat_depense = EtatDepense.new
  end

  # GET /etat_depenses/1/edit
  def edit
  end

  # POST /etat_depenses
  # POST /etat_depenses.json
  def create
    @etat_depense = EtatDepense.new(etat_depense_params)
    @etat_depense.date = @etat_depense.date.change(month: 1, day: 1)
    respond_to do |format|
      if @etat_depense.save
        format.html { redirect_to etat_depenses_path, notice: 'Etat depense was successfully created.' }
        format.json { render :show, status: :created, location: @etat_depense }
      else
        format.html { render :new }
        format.json { render json: @etat_depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etat_depenses/1
  # PATCH/PUT /etat_depenses/1.json
  def update
    respond_to do |format|
      if @etat_depense.update(etat_depense_params)
        format.html { redirect_to etat_depenses_path, notice: 'Etat depense was successfully updated.' }
        format.json { render :show, status: :ok, location: @etat_depense }
      else
        format.html { render :edit }
        format.json { render json: @etat_depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etat_depenses/1
  # DELETE /etat_depenses/1.json
  def destroy
    @etat_depense.destroy
    respond_to do |format|
      format.html { redirect_to etat_depenses_url, notice: 'Etat depense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etat_depense
      @etat_depense = EtatDepense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def etat_depense_params
      params.require(:etat_depense).permit(:date, :beneficiaire, :titre, :categorie, :ae_prevu, :ae_conso, :cp_prevu, :cp_conso)
    end
end
