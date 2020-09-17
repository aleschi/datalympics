class EtatBudgetsController < ApplicationController
  before_action :set_etat_budget, only: [:show, :edit, :update, :destroy]

  # GET /etat_budgets
  # GET /etat_budgets.json
  def index
    @etat_budgets = EtatBudget.all
    if !EtatBudget.last.nil?
      @etat_budget_actuel = EtatBudget.last
    else
      @etat_budget_actuel = 1103000000
    end
    if !EtatBudget.first.nil?
      @etat_budget_first = EtatBudget.first
    else
    end
  end

  # GET /etat_budgets/1
  # GET /etat_budgets/1.json
  def show
  end

  # GET /etat_budgets/new
  def new
    @etat_budget = EtatBudget.new
  end

  # GET /etat_budgets/1/edit
  def edit
  end

  # POST /etat_budgets
  # POST /etat_budgets.json
  def create
    @etat_budget = EtatBudget.new(etat_budget_params)

    respond_to do |format|
      if @etat_budget.save
        format.html { redirect_to @etat_budget, notice: 'Etat budget was successfully created.' }
        format.json { render :show, status: :created, location: @etat_budget }
      else
        format.html { render :new }
        format.json { render json: @etat_budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etat_budgets/1
  # PATCH/PUT /etat_budgets/1.json
  def update
    respond_to do |format|
      if @etat_budget.update(etat_budget_params)
        format.html { redirect_to @etat_budget, notice: 'Etat budget was successfully updated.' }
        format.json { render :show, status: :ok, location: @etat_budget }
      else
        format.html { render :edit }
        format.json { render json: @etat_budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etat_budgets/1
  # DELETE /etat_budgets/1.json
  def destroy
    @etat_budget.destroy
    respond_to do |format|
      format.html { redirect_to etat_budgets_url, notice: 'Etat budget was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etat_budget
      @etat_budget = EtatBudget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def etat_budget_params
      params.require(:etat_budget).permit(:date, :budget_total, :budget_solideo, :budget_cojo, :budget_heritage, :budget_hauteperformance)
    end
end
