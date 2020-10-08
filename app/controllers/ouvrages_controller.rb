class OuvragesController < ApplicationController
  before_action :set_ouvrage, only: [:show, :edit, :update, :destroy]
  require 'csv'
  # GET /ouvrages
  # GET /ouvrages.json
  def index
    @ouvrages = Ouvrage.all
    @ouvrages_financements = OuvragesFinancement.all
  end

  # GET /ouvrages/1
  # GET /ouvrages/1.json
  def show
   
    @ouvrage_financements = OuvragesFinancement.all.where('ouvrage_id = ?', @ouvrage.id)
    @ouvrage_depenses = OuvragesDepense.all.where('ouvrage_id = ?', @ouvrage.id)
    @ouvrage_financeurs_hash = @ouvrage_financements.group(:name).sum('montant')
    @ouvrage_financeurs = []
    @ouvrage_financeurs_hash.each do |h|
      if !h[0].nil?
      @ouvrage_financeurs << h[0]
      end
    end
    
  end

  # GET /ouvrages/new
  def new
    @ouvrage = Ouvrage.new
  end

  # GET /ouvrages/1/edit
  def edit
  end


  def import
    Ouvrage.import(params[:file])
    redirect_to ouvrages_path
    
  end 
  
  # POST /ouvrages
  # POST /ouvrages.json
  def create 
    @ouvrage = Ouvrage.new(ouvrage_params)

    respond_to do |format|
      if @ouvrage.save
        format.html { redirect_to @ouvrage, notice: 'Ouvrage was successfully created.' }
        format.json { render :show, status: :created, location: @ouvrage }
      else
        format.html { render :new }
        format.json { render json: @ouvrage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ouvrages/1
  # PATCH/PUT /ouvrages/1.json
  def update
    respond_to do |format|
      if @ouvrage.update(ouvrage_params)
        format.html { redirect_to @ouvrage, notice: 'Ouvrage was successfully updated.' }
        format.json { render :show, status: :ok, location: @ouvrage }
      else
        format.html { render :edit }
        format.json { render json: @ouvrage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ouvrages/1
  # DELETE /ouvrages/1.json
  def destroy
    @ouvrage.destroy
    respond_to do |format|
      format.html { redirect_to ouvrages_url, notice: 'Ouvrage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ouvrage
      @ouvrage = Ouvrage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ouvrage_params
      params.require(:ouvrage).permit(:name, :adresse, :maitre_oeuvre, :budget)
    end
end
