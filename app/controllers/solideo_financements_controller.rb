class SolideoFinancementsController < ApplicationController
  before_action :set_solideo_financement, only: [:show, :edit, :update, :destroy]

  # GET /solideo_financements
  # GET /solideo_financements.json
  def index
    @solideo_financements = SolideoFinancement.all
    @solideo_financements_etat = SolideoFinancement.where("financeur = ?", "Etat").first.financement_prevu
    @solideo_financements_collectivites = SolideoFinancement.where("financeur != ?", "etat").sum(:financement_prevu)
  end

  # GET /solideo_financements/1
  # GET /solideo_financements/1.json
  def show
  end

  # GET /solideo_financements/new
  def new
    @solideo_financement = SolideoFinancement.new
  end

  # GET /solideo_financements/1/edit
  def edit
  end
  
  def import
    SolideoFinancement.all.destroy_all
    SolideoFinancement.import(params[:file])
    redirect_to solideo_financements_path
    
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
      params.require(:solideo_financement).permit(:financeur, :financement_prevu, :financement_2018, :financement_2019, :financement_2020, :financement_2021, :financement_2022, :financement_2023, :financement_2024, :financement_2025)
    end
end
