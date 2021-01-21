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
    @bops = @chorus.select { |choru| choru.centre_financier.count("-") == 1 }
    
    #compter le nombre de bop differents 
    @bop_arr = []
    @bops.each do |bop|
      @bop_arr << bop.centre_financier
    end 
    @bop_arr.uniq!
    @bop = Choru.where('centre_financier = ?', @bop_arr[0] ).order('date ASC')
    @bop_ht2 = @bop.where("compte_budgetaire = ?", "HT2")
    @bop_t2 = @bop.where("compte_budgetaire = ?", "T2")
    
    @uos = @chorus.select { |choru| choru.centre_financier.count("-") == 2 }
    #compter le nombre de bop differents 
    @uo_arr = []
    @uos.each do |uo|
      @uo_arr << uo.centre_financier
    end 
    @uo_arr.uniq!
    @uo = Choru.where('centre_financier = ?', @uo_arr[0] ).order('date ASC')
    @uo_ht2 = @uo.where("compte_budgetaire = ?", "HT2")
    @uo_t2 = @uo.where("compte_budgetaire = ?", "T2")
  end 
  
  def select_bop
    @bop = Choru.where('centre_financier = ?', params[:id]).order('date ASC')
    @bop_ht2 = @bop.where("compte_budgetaire = ?", "HT2")
    @bop_t2 = @bop.where("compte_budgetaire = ?", "T2")
  end 
  def select_uo
    @uo = Choru.where('centre_financier = ?', params[:id])
    @uo_ht2 = @uo.where("compte_budgetaire = ?", "HT2")
    @uo_t2 = @uo.where("compte_budgetaire = ?", "T2")
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
