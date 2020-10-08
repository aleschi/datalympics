class OuvragesDepensesController < ApplicationController
  before_action :set_ouvrages_depense, only: [:show, :edit, :update, :destroy]

  # GET /ouvrages_depenses
  # GET /ouvrages_depenses.json
  def index
    @ouvrages_depenses = OuvragesDepense.all
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
      params.require(:ouvrages_depense).permit(:date, :ouvrage_id, :name, :montant)
    end
end