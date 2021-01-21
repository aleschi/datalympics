class ChorusController < ApplicationController

  def index
    @chorus = Choru.all 
  end 
  
  def new
    @choru = Choru.new
  end 
  
  def import
   Choru.import(params[:file])
    redirect_to chorus_path 
  end 
  
  def update 
  end 
  
  def show
    @search = params[:id]
    @chorus = Choru.where('centre_financier like ?', '%'+@search+'%').order('date ASC')
    @programme = Choru.where('centre_financier = ?', @search ).order('date ASC')
    @programme_ht2 = @programme.where("compte_budgetaire = ?", "HT2")
    @programme_t2 = @programme.where("compte_budgetaire = ?", "T2")
    @bop = @chorus.select { |choru| choru.centre_financier.count("-") == 1 }
    #compter le nombre de bop differents 
    @bop_arr = []
    @bop.each do |bop|
      @bop_arr << bop.centre_financier
    end 
    @bop_arr.uniq!
    
    @uo = @chorus.select { |choru| choru.centre_financier.count("-") == 2 }
  
  end 
  
  def edit
    @choru=Choru.find(params[:id])
  end 
  
  def destroy
    @choru=Choru.find(params[:id])
    @choru.destroy
    redirect_to chorus_path
  end
  
  private

    def choru_params
      params.require(:choru).permit(:date, :type_piece, :type_budget, :operation, :centre_financier, :compte_budgetaire, :montant)
    end

end
