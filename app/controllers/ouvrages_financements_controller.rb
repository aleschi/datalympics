class OuvragesFinancementsController < ApplicationController
  before_action :set_ouvrages_financement, only: [:show, :edit, :update, :destroy]

  # GET /ouvrages_financements
  # GET /ouvrages_financements.json
  def index
    @ouvrages_financements = OuvragesFinancement.all
  end

  # GET /ouvrages_financements/1
  # GET /ouvrages_financements/1.json
  def show
  end

  # GET /ouvrages_financements/new
  def new
    @ouvrages_financement = OuvragesFinancement.new
  end

  # GET /ouvrages_financements/1/edit
  def edit
  end
  
  def import
    @ouvrages_financements = OuvragesFinancement.import_ouvrage(params[:file], params[:date_year].to_i, params[:date_month].to_i)
    redirect_to ouvrages_financements_path
  end

  # POST /ouvrages_financements
  # POST /ouvrages_financements.json
  def create
    @ouvrages_financement = OuvragesFinancement.new(ouvrages_financement_params)

    respond_to do |format|
      if @ouvrages_financement.save
        format.html { redirect_to ouvrages_financements_path, notice: 'Ouvrages financement was successfully created.' }
        format.json { render :show, status: :created, location: @ouvrages_financement }
      else
        format.html { render :new }
        format.json { render json: @ouvrages_financement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ouvrages_financements/1
  # PATCH/PUT /ouvrages_financements/1.json
  def update
    respond_to do |format|
      if @ouvrages_financement.update(ouvrages_financement_params)
        format.html { redirect_to ouvrages_financements_path, notice: 'Ouvrages financement was successfully updated.' }
        format.json { render :show, status: :ok, location: @ouvrages_financement }
      else
        format.html { render :edit }
        format.json { render json: @ouvrages_financement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ouvrages_financements/1
  # DELETE /ouvrages_financements/1.json
  def destroy
    @ouvrages_financement.destroy
    respond_to do |format|
      format.html { redirect_to ouvrages_financements_url, notice: 'Ouvrages financement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ouvrages_financement
      @ouvrages_financement = OuvragesFinancement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ouvrages_financement_params
      params.require(:ouvrages_financement).permit(:date, :ouvrage_id, :name, :montant)
    end
end
