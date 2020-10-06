class SolideoDepensesController < ApplicationController
  before_action :set_solideo_depense, only: [:show, :edit, :update, :destroy]

  # GET /solideo_depenses
  # GET /solideo_depenses.json
  def index
    @solideo_depenses = SolideoDepense.all
    @solideo_financements = SolideoFinancement.all
   
    
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
