class SolideoDepensesController < ApplicationController
  before_action :set_solideo_depense, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /solideo_depenses
  # GET /solideo_depenses.json
  def index
     @nav=true


    #droits constates ouvrage moa solideo
    if SolideoStructureDepense.count > 0
      @list_structure_moas = SolideoStructure.where(categorie: "OUVRAGE MOA SOLIDEO").pluck(:id)
      @droits_constates_moas = SolideoStructureDepense.where(solideo_structure_id: @list_structure_moas).where('date = ?',SolideoStructureDepense.order(date: :asc).last.date).sum('droits_constates_cumul')
      @budget_moas = SolideoStructureBudget.where(solideo_structure_id: @list_structure_moas).where('date = ?',SolideoStructureBudget.order(date: :asc).last.date).sum('budget_global')
      @droits_constates_moas_annee = SolideoStructureDepense.where(solideo_structure_id: @list_structure_moas).where('date = ?',SolideoStructureDepense.order(date: :asc).last.date).sum('droits_constates_annee')
      @budget_moas_annee = SolideoStructureBudget.where(solideo_structure_id: @list_structure_moas).where('date = ?',SolideoStructureBudget.order(date: :asc).last.date).sum('budget_annee')
      
      @list_structure_moahs = SolideoStructure.where(categorie: "OUVRAGE HORS MOA SOLIDEO").pluck(:id)
      @droits_constates_moahs = SolideoStructureDepense.where(solideo_structure_id: @list_structure_moahs).where('date = ?',SolideoStructureDepense.order(date: :asc).last.date).sum('droits_constates_cumul')
      @budget_moahs = SolideoStructureBudget.where(solideo_structure_id: @list_structure_moahs).where('date = ?',SolideoStructureBudget.order(date: :asc).last.date).sum('budget_global')
      @droits_constates_moahs_annee = SolideoStructureDepense.where(solideo_structure_id: @list_structure_moahs).where('date = ?',SolideoStructureDepense.order(date: :asc).last.date).sum('droits_constates_annee')
      @budget_moahs_annee = SolideoStructureBudget.where(solideo_structure_id: @list_structure_moahs).where('date = ?',SolideoStructureBudget.order(date: :asc).last.date).sum('budget_annee')
      
      @list_structure_f = SolideoStructure.where(categorie: "FONCTIONNEMENT").pluck(:id)
      @droits_constates_f = SolideoStructureDepense.where(solideo_structure_id: @list_structure_f).where('date = ?',SolideoStructureDepense.order(date: :asc).last.date).sum('droits_constates_cumul')
      @budget_f = SolideoStructureBudget.where(solideo_structure_id: @list_structure_f).where('date = ?',SolideoStructureBudget.order(date: :asc).last.date).sum('budget_global')
      @droits_constates_f_annee = SolideoStructureDepense.where(solideo_structure_id: @list_structure_f).where('date = ?',SolideoStructureDepense.order(date: :asc).last.date).sum('droits_constates_annee')
      @budget_f_annee = SolideoStructureBudget.where(solideo_structure_id: @list_structure_f).where('date = ?',SolideoStructureBudget.order(date: :asc).last.date).sum('budget_annee')
      
      @list_structure_ri = SolideoStructure.where(categorie: "RESERVES ET INNOVATION").pluck(:id)
      @droits_constates_ri = SolideoStructureDepense.where(solideo_structure_id: @list_structure_ri).where('date = ?',SolideoStructureDepense.order(date: :asc).last.date).sum('droits_constates_cumul')
      @budget_ri = SolideoStructureBudget.where(solideo_structure_id: @list_structure_ri).where('date = ?',SolideoStructureBudget.order(date: :asc).last.date).sum('budget_global')
      @droits_constates_ri_annee = SolideoStructureDepense.where(solideo_structure_id: @list_structure_ri).where('date = ?',SolideoStructureDepense.order(date: :asc).last.date).sum('droits_constates_annee')
      @budget_ri_annee = SolideoStructureBudget.where(solideo_structure_id: @list_structure_ri).where('date = ?',SolideoStructureBudget.order(date: :asc).last.date).sum('budget_annee')
      
      @dates_depenses_reporting = SolideoStructureDepense.order('date DESC').pluck(:date).uniq

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

  def new_structure
  end 

  def import_structure
    SolideoStructure.import(params[:file])
    redirect_to solideo_depenses_path
  end 
  def import_depenses
    SolideoStructureDepense.import(params[:file])
    redirect_to solideo_depenses_path
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
