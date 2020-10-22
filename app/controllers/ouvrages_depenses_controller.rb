class OuvragesDepensesController < ApplicationController
  before_action :set_ouvrages_depense, only: [:show, :edit, :update, :destroy]

  # GET /ouvrages_depenses
  # GET /ouvrages_depenses.json
  def index 
    @ouvrages = Ouvrage.all
    @ouvrages_depenses = OuvragesDepense.all
    
     @solideo_depenses_ouvrages_prevu = OuvragesDepense.all.unscope(:order).group(:date).sum('montant_prevu')
    @solideo_depenses_ouvrages_reel = OuvragesDepense.where('date <= ?', Date.today).unscope(:order).group(:date).sum('montant')
    
    
    @solideo_depenses_ouvrages = OuvragesDepense.all.sum('montant')
    @solideo_depenses_ouvrages_prevu_date = OuvragesDepense.where('date <= ?', Date.today).sum('montant_prevu')
    
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
    
    @h_depenses_annee = OuvragesDepense.all.unscope(:order).group_by_year(:date).sum('montant')
    @h_depenses_prevu_annee = OuvragesDepense.all.unscope(:order).group_by_year(:date).sum('montant_prevu')
    @depenses_annee = []
    @depenses_prevu_annee = []
    @depenses_prevu_annee_maj = []
    (2018..2025).each do |annee|    
      @is_present = false 
      @h_depenses_annee.each do |h|
        if h[0].year == annee
          @depenses_annee << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_annee << 0
      end
    end
    @depenses_prevu_annee_maj_value = [244252000,157128000,83950000,224300000,254300000,210000000,94000000,0]

    (2018..2025).each do |annee|    
      @is_present = false 
      @h_depenses_prevu_annee.each do |h|
        if h[0].year == annee
          @depenses_prevu_annee << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_prevu_annee << 0
      end
    end
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
  
    OuvragesDepense.import(params[:file])

    redirect_to ouvrages_depenses_path
  end 
  def import2
OuvragesDepense.all.destroy_all
    OuvragesDepense.import2(params[:file])

    redirect_to ouvrages_depenses_path
  end 
  def import3

    OuvragesDepense.import3(params[:file])

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
