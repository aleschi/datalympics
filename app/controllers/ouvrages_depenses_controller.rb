class OuvragesDepensesController < ApplicationController
  before_action :set_ouvrages_depense, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /ouvrages_depenses
  # GET /ouvrages_depenses.json
  def index 
     @nav=true
    @ouvrages = Ouvrage.all
    @ouvrages_depenses = OuvragesDepense.all
    @ouvrages_financements = OuvragesFinancement.all 
    @budget_diminution = 0
    @budget_augmentation = 0
    @budget_nouveau = 0
    
    Ouvrage.all.each do |ouvrage|
      if ouvrage.ouvrages_financements.count > 0
        if ouvrage.ouvrages_financements.where('date = ?', ouvrage.ouvrages_financements.order('date DESC').first.date).first.montant_prevu-ouvrage.ouvrages_financements.where('date = ?', ouvrage.ouvrages_financements.order('date ASC').first.date).first.montant_prevu < 0 
          @budget_diminution += ouvrage.ouvrages_financements.where('date = ?', ouvrage.ouvrages_financements.order('date DESC').first.date).first.montant_prevu-ouvrage.ouvrages_financements.where('date = ?', ouvrage.ouvrages_financements.order('date ASC').first.date).first.montant_prevu
        else
          if ouvrage.ouvrages_financements.where('date = ?', Date.new(2018,1)).count > 0
            @budget_augmentation += ouvrage.ouvrages_financements.where('date = ?', ouvrage.ouvrages_financements.order('date DESC').first.date).first.montant_prevu-ouvrage.ouvrages_financements.where('date = ?', ouvrage.ouvrages_financements.order('date ASC').first.date).first.montant_prevu
          else 
            @budget_nouveau += ouvrage.ouvrages_financements.where('date = ?', ouvrage.ouvrages_financements.order('date DESC').first.date).first.montant_prevu
          end 
          
        end 
      end 
    end
    
    @ecart_reserve = SolideoFinancement.where("categorie = ? AND date = ?","reserve", SolideoFinancement.order('date DESC').first.date).sum('montant')-SolideoFinancement.where("categorie = ? AND date = ?","reserve", Date.new(2018,1)).sum('montant') + SolideoFinancement.where("categorie = ? AND date = ?","innovation", SolideoFinancement.order('date DESC').first.date).sum('montant') -SolideoFinancement.where("categorie = ? AND date = ?","innovation", Date.new(2018,1)).sum('montant')
  
  end

  # GET /ouvrages_depenses/1
  # GET /ouvrages_depenses/1.json
  def show
  end

  # GET /ouvrages_depenses/new
  def new
    @ouvrages_depense = OuvragesDepense.new
  end

  # GET /ouvrages_depenses/1/edit
  def edit
  end

  # POST /ouvrages_depenses
  # POST /ouvrages_depenses.json
  def create
    @ouvrages_depense = OuvragesDepense.new(ouvrages_depense_params)

    respond_to do |format|
      if @ouvrages_depense.save
        format.html { redirect_to @ouvrages_depense, notice: 'Ouvrages depense was successfully created.' }
        format.json { render :show, status: :created, location: @ouvrages_depense }
      else
        format.html { render :new }
        format.json { render json: @ouvrages_depense.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def import
    OuvragesDepense.all.destroy_all
    
    OuvragesDepense.import(params[:file])

    redirect_to ouvrages_depenses_path
  end 


  # PATCH/PUT /ouvrages_depenses/1
  # PATCH/PUT /ouvrages_depenses/1.json
  def update
    respond_to do |format|
      if @ouvrages_depense.update(ouvrages_depense_params)
        format.html { redirect_to @ouvrages_depense, notice: 'Ouvrages depense was successfully updated.' }
        format.json { render :show, status: :ok, location: @ouvrages_depense }
      else
        format.html { render :edit }
        format.json { render json: @ouvrages_depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ouvrages_depenses/1
  # DELETE /ouvrages_depenses/1.json
  def destroy
    @ouvrages_depense.destroy
    respond_to do |format|
      format.html { redirect_to ouvrages_depenses_url, notice: 'Ouvrages depense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ouvrages_depense
      @ouvrages_depense = OuvragesDepense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ouvrages_depense_params
      params.require(:ouvrages_depense).permit(:date, :ouvrage_id, :name, :montant, :montant_prevu, :montant_engage, :date_maquette)
    end
end
