class OuvragesFinanceursController < ApplicationController
  before_action :set_ouvrages_financeur, only: [:show, :edit, :update, :destroy]

  # GET /ouvrages_financeurs
  # GET /ouvrages_financeurs.json
  def index
    @ouvrages_financeurs = OuvragesFinanceur.all
  end

  # GET /ouvrages_financeurs/1
  # GET /ouvrages_financeurs/1.json
  def show
  end

  # GET /ouvrages_financeurs/new
  def new
    @ouvrages_financeur = OuvragesFinanceur.new
  end

  # GET /ouvrages_financeurs/1/edit
  def edit
  end
  
  def import
    OuvragesFinanceur.import(params[:file])
    redirect_to ouvrages_financeurs_path
  end 

  # POST /ouvrages_financeurs
  # POST /ouvrages_financeurs.json
  def create
    @ouvrages_financeur = OuvragesFinanceur.new(ouvrages_financeur_params)

    respond_to do |format|
      if @ouvrages_financeur.save
        format.html { redirect_to ouvrages_financeurs_path, notice: 'Ouvrages financeur was successfully created.' }
        format.json { render :show, status: :created, location: @ouvrages_financeur }
      else
        format.html { render :new }
        format.json { render json: @ouvrages_financeur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ouvrages_financeurs/1
  # PATCH/PUT /ouvrages_financeurs/1.json
  def update
    respond_to do |format|
      if @ouvrages_financeur.update(ouvrages_financeur_params)
        format.html { redirect_to ouvrages_financeurs_path, notice: 'Ouvrages financeur was successfully updated.' }
        format.json { render :show, status: :ok, location: @ouvrages_financeur }
      else
        format.html { render :edit }
        format.json { render json: @ouvrages_financeur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ouvrages_financeurs/1
  # DELETE /ouvrages_financeurs/1.json
  def destroy
    @ouvrages_financeur.destroy
    respond_to do |format|
      format.html { redirect_to ouvrages_financeurs_url, notice: 'Ouvrages financeur was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ouvrages_financeur
      @ouvrages_financeur = OuvragesFinanceur.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ouvrages_financeur_params
      params.require(:ouvrages_financeur).permit(:ouvrage_id, :name, :financement_prevu, :financement_actuel)
    end
end
