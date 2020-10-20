class SolideoDepensesController < ApplicationController
  before_action :set_solideo_depense, only: [:show, :edit, :update, :destroy]

  # GET /solideo_depenses
  # GET /solideo_depenses.json
  def index
    @solideo_depenses = SolideoDepense.all
    @solideo_financements = SolideoFinancement.all
    @solideo_depenses_total = OuvragesDepense.all.sum('montant') + @solideo_financements.where('categorie = ?', "reserve").sum('montant') + @solideo_financements.where('categorie = ?', "innovation").sum('montant') + @solideo_financements.where('categorie = ?', "fonctionnement").sum('montant')
  @solideo_depenses_total_prevu = OuvragesDepense.where('date <= ?', Date.today).sum('montant_prevu') + @solideo_financements.where('categorie = ? AND date <= ?', "reserve", Date.today).sum('montant_prevu') + @solideo_financements.where('categorie = ? AND date <= ?', "innovation", Date.today).sum('montant_prevu') + @solideo_financements.where('categorie = ? AND date <= ?', "fonctionnement", Date.today).sum('montant_prevu')


    @solideo_depenses_ouvrages = OuvragesDepense.all.sum('montant')
    @solideo_depenses_ouvrages_prevu_date = OuvragesDepense.where('date <= ?', Date.today).sum('montant_prevu')

    @h1 = OuvragesDepense.all.unscope(:order).group_by_year(:date).sum('montant')
    @h2 =  @solideo_financements.where('categorie != ? ', "ouvrages").unscope(:order).group_by_year(:date).sum('montant')
    @h_depenses_annee = @h1.merge(@h2){|k,a,b| a+b}
    @h3 = OuvragesDepense.all.unscope(:order).group_by_year(:date).sum('montant_prevu')
    @h4 =  @solideo_financements.where('categorie != ?', "ouvrages").unscope(:order).group_by_year(:date).sum('montant_prevu')
    @h_depenses_prevu_annee = @h3.merge(@h4){|k,a,b| a+b}
    @depenses_annee = []
    @depenses_prevu_annee = []
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
    
    #ouvrages 
    @depenses_annee_ouvrages = []
    @depenses_prevu_annee_ouvrages = []
    (2018..2025).each do |annee|    
      @is_present = false 
      @h1.each do |h|
        if h[0].year == annee
          @depenses_annee_ouvrages << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_annee_ouvrages << 0
      end
    end
    (2018..2025).each do |annee|    
      @is_present = false 
      @h3.each do |h|
        if h[0].year == annee
          @depenses_prevu_annee_ouvrages << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_prevu_annee_ouvrages << 0
      end
    end
    
    #fonctionnement
    @fonctionnement_a =  @solideo_financements.where('categorie = ? AND date <= ?', "fonctionnement", Date.today).unscope(:order).group_by_year(:date).sum('montant')    
    @fonctionnement_p =  @solideo_financements.where('categorie = ? ', "fonctionnement").unscope(:order).group_by_year(:date).sum('montant_prevu')
     @depenses_annee_fonctionnement = []
    @depenses_prevu_annee_fonctionnement = []
    (2018..2025).each do |annee|    
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
    (2018..2025).each do |annee|    
      @is_present = false 
       @fonctionnement_p.each do |h|
        if h[0].year == annee
          @depenses_prevu_annee_fonctionnement << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_prevu_annee_fonctionnement << 0
      end
    end
    #innovation
    @innovation_a =  @solideo_financements.where('categorie = ? AND date <= ?', "innovation", Date.today).unscope(:order).group_by_year(:date).sum('montant')    
    @innovation_p =  @solideo_financements.where('categorie = ? ', "innovation").unscope(:order).group_by_year(:date).sum('montant_prevu')
     @depenses_annee_innovation = []
    @depenses_prevu_annee_innovation = []
    (2018..2025).each do |annee|    
      @is_present = false 
       @innovation_a.each do |h|
        if h[0].year == annee
          @depenses_annee_innovation << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_annee_innovation << 0
      end
    end
    (2018..2025).each do |annee|    
      @is_present = false 
       @innovation_p.each do |h|
        if h[0].year == annee
          @depenses_prevu_annee_innovation << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_prevu_annee_innovation << 0
      end
    end
    
     #reserve
    @reserve_a =  @solideo_financements.where('categorie = ? AND date <= ?', "reserve", Date.today).unscope(:order).group_by_year(:date).sum('montant')    
    @reserve_p =  @solideo_financements.where('categorie = ? ', "reserve").unscope(:order).group_by_year(:date).sum('montant_prevu')
     @depenses_annee_reserve = []
    @depenses_prevu_annee_reserve = []
    (2018..2025).each do |annee|    
      @is_present = false 
       @reserve_a.each do |h|
        if h[0].year == annee
          @depenses_annee_reserve << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_annee_reserve << 0
      end
    end
    (2018..2025).each do |annee|    
      @is_present = false 
       @reserve_p.each do |h|
        if h[0].year == annee
          @depenses_prevu_annee_reserve << h[1]
          @is_present = true 
        end 
      end
      if @is_present == false 
         @depenses_prevu_annee_reserve << 0
      end
    end
    
  @solideo_financements_dates_ouvrages = OuvragesDepense.all.order('date DESC').unscope(:order).group(:date).sum('montant')
  @solideo_financements_dates_ouvrages_keys = @solideo_financements_dates_ouvrages.keys
  @solideo_financements_dates_ouvrages_values = @solideo_financements_dates_ouvrages.values
  @sum = 0
  @solideo_financements_dates_ouvrages_values.map!{|x| @sum += x}
  @solideo_financements_dates_ouvrages_tuple = @solideo_financements_dates_ouvrages_keys.zip(@solideo_financements_dates_ouvrages_values)
   
  @solideo_financements_dates_reserve = @solideo_financements.where('categorie = ?', "reserve").order('date DESC').unscope(:order).group(:date).sum('montant')
  @solideo_financements_dates_innovation = @solideo_financements.where('categorie = ?', "innovation").order('date DESC').unscope(:order).group(:date).sum('montant')   
  @solideo_financements_dates_fonctionnement = @solideo_financements.where('categorie = ?', "fonctionnement").order('date DESC').unscope(:order).group(:date).sum('montant')
 
  @solideo_depenses_ouvrages_total =  OuvragesDepense.all.sum('montant')

    @solideo_depenses_ouvrages_prevu = OuvragesDepense.all.unscope(:order).group(:date).sum('montant_prevu')
    @solideo_depenses_ouvrages_reel = OuvragesDepense.all.unscope(:order).group(:date).sum('montant')
    
    @financeurs_hash = @solideo_financements.group(:financeur).sum('montant')
    @financeurs = []
    @financeurs_hash.each do |h|
      @financeurs << h[0]
    end
    
    @solideo_depenses_hash = SolideoFinancement.where('date <= ?', Date.today).order('date DESC').group(:date).sum('montant')
    @solideo_depenses_array = []
    
      @solideo_depenses_hash.each do |h|
        if !h[0].nil?
        @solideo_depenses_array << h[0]
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
