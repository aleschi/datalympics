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
    @date = Date.new(2019,12,31)
    @dates = ['2020']
    if !Choru.where('centre_financier = ? ', @search).first.nil?
      @begin =  Choru.where('centre_financier = ? ', @search).order('date ASC').first.date.year
      @end =  Choru.where('centre_financier = ? ', @search).order('date ASC').last.date.year
      @chorus = Choru.where('centre_financier like ? ', '%'+@search+'%').order('date ASC')
      @programme = Choru.where('centre_financier = ? AND date >= ? AND date < ? ', @search, @date, @date + 1.year).order('date ASC')
      @programme_ht2 = @programme.where("compte_budgetaire = ?", "HT2")
      @programme_t2 = @programme.where("compte_budgetaire = ?", "T2")
      @type_pieces=[]
      @programme.each do |choru|
        @type_pieces << choru.type_piece
      end 
      @type_pieces.uniq! 
      
      @bops = @chorus.select { |choru| choru.centre_financier.count("-") == 1 }

      #compter le nombre de bop differents 
      @bop_arr = []
      @bops.each do |bop|
        @bop_arr << bop.centre_financier
      end 
      @bop_arr.uniq!
      @bop = Choru.where('centre_financier = ? AND date >= ? AND date < ? ', @bop_arr[0],@date, @date + 1.year ).order('date ASC')
      @bop_ht2 = @bop.where("compte_budgetaire = ?", "HT2")
      @bop_t2 = @bop.where("compte_budgetaire = ?", "T2")

      #@uos = @chorus.select { |choru| choru.centre_financier.count("-") == 2 }
      #compter le nombre de bop differents 
      @uo_search = @bop.first.centre_financier + '-'
      @uos = Choru.where('centre_financier like ? ', '%'+@uo_search+'%').order('date ASC')
      @uo_arr = []
      @uos.each do |uo|
        @uo_arr << uo.centre_financier
      end 
      @uo_arr.uniq! 
      @uo = Choru.where('centre_financier = ?  AND date >= ? AND date < ?', @uo_arr[0],@date, @date + 1.year ).order('date ASC')
      @uo_ht2 = @uo.where("compte_budgetaire = ? OR (compte_budgetaire != ? AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?)  ", "HT2", "T2", "21","22","23","24","25","26").order('date ASC')
      @uo_t2 = @uo.where("compte_budgetaire = ? OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ? ", "T2", "21","22","23","24","25","26").order('date ASC')
      #nombre d'actions 
     #nombre d'actions 
      @uo_actions = []
      @uo.where.not(domaine_fonctionnel: nil).each do |uo|
        @uo_actions << uo.domaine_fonctionnel
      end 
      @uo_actions.uniq!
      @uo_action = @uo_actions[0]
    end
  end 
  
  def select_date_programme
    @search = params[:id]
    @chorus =  Choru.where('centre_financier like ? ', '%'+@search+'%').order('date ASC')
    @begin = Choru.where('centre_financier = ? ', @search).order('date ASC').first.date.year
    @end =  Choru.where('centre_financier = ? ', @search).order('date ASC').last.date.year
    @programme =  Choru.where('date = ?', Date.new(1000))
    @bop = Choru.where('date = ?', Date.new(1000))
    @uo = Choru.where('date = ?', Date.new(1000))
    @dates = params[:date]
    @dates.each do |date|
      @date_c = Date.new(date.to_i-1,12,1)
      @programme = @programme.or(Choru.where('centre_financier = ? AND date >= ? AND date < ? ', @search, @date_c, @date_c + 1.year))
    end 
    @programme = @programme.order('date ASC')
    @programme_ht2 = @programme.where("compte_budgetaire = ?", "HT2")
    @programme_t2 = @programme.where("compte_budgetaire = ?", "T2")
    @type_pieces=[]
      @programme.each do |choru|
        @type_pieces << choru.type_piece
      end 
      @type_pieces.uniq! 
    @bops = @chorus.select { |choru| choru.centre_financier.count("-") == 1 }
    
    #compter le nombre de bop differents 
    @bop_arr = []
    @bops.each do |bop|
      @bop_arr << bop.centre_financier
    end 
    @bop_arr.uniq!
    
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1) 
      @bop = @bop.or(Choru.where('centre_financier = ? AND date >= ? AND date < ? ', @bop_arr[0],@date, @date + 1.year ))
    end
    @bop = @bop.order('date ASC')
    @bop_ht2 = @bop.where("compte_budgetaire = ?", "HT2")
    @bop_t2 = @bop.where("compte_budgetaire = ?", "T2")
    
    #@uos = @chorus.select { |choru| choru.centre_financier.count("-") == 2 }
    #compter le nombre de uo differents 
    @uo_search = @bop.first.centre_financier + '-'
    @uos = Choru.where('centre_financier like ?', '%'+@uo_search+'%' ).order('date ASC')
    @uo_arr = []
    @uos.each do |uo|
      @uo_arr << uo.centre_financier
    end 
    @uo_arr.uniq! 
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1)
      @uo = @uo.or(Choru.where('centre_financier = ?  AND date >= ? AND date < ?', @uo_arr[0],@date, @date + 1.year ))
    end
    @uo = @uo.order('date ASC')
    @uo_ht2 = @uo.where("compte_budgetaire = ? OR (compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?)  ", "HT2", "21","22","23","24","25","26").order('date ASC')
    @uo_t2 = @uo.where("compte_budgetaire = ? OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ? ", "T2", "21","22","23","24","25","26").order('date ASC')
    #nombre d'actions 
   #nombre d'actions 
    @uo_actions = []
    @uo.where.not(domaine_fonctionnel: nil).each do |uo|
      @uo_actions << uo.domaine_fonctionnel
    end 
    @uo_actions.uniq!
    @uo_action = @uo_actions[0]
  end
  
  def select_bop
    @dates = params[:date]
    #@bop = Choru.where('centre_financier = ?', params[:id]).order('date ASC')
    @bop = Choru.where('date = ?', Date.new(1000))
    @uo = Choru.where('date = ?', Date.new(1000))
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1) 
      @bop = @bop.or(Choru.where('centre_financier = ? AND date >= ? AND date < ? ', params[:id],@date, @date + 1.year ))
    end
    @bop_ht2 = @bop.where("compte_budgetaire = ?", "HT2")
    @bop_t2 = @bop.where("compte_budgetaire = ?", "T2")
    @uo_search = @bop.first.centre_financier + '-'
    @uos = Choru.where('centre_financier like ?', '%'+@uo_search+'%' ).order('date ASC')
    @uo_arr = []
    @uos.each do |uo|
      @uo_arr << uo.centre_financier
    end 
    @uo_arr.uniq! 
   
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1)
      @uo = @uo.or(Choru.where('centre_financier = ?  AND date >= ? AND date < ?', @uo_arr[0],@date, @date + 1.year ))
    end
    @uo_ht2 = @uo.where("compte_budgetaire = ? OR (compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?)  ", "HT2", "21","22","23","24","25","26").order('date ASC')
    @uo_t2 = @uo.where("compte_budgetaire = ? OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ? ", "T2", "21","22","23","24","25","26").order('date ASC')
    #nombre d'actions 
    @uo_actions = []
    @uo.where.not(domaine_fonctionnel: nil).each do |uo|
      @uo_actions << uo.domaine_fonctionnel
    end 
    @uo_actions.uniq!
    @uo_action = @uo_actions[0]
  end 
  
  def select_uo
    @dates = params[:date]
    #@uo = Choru.where('centre_financier = ?', params[:id]).order('date ASC')
    @uo = Choru.where('date = ?', Date.new(1000))
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1)
      @uo = @uo.or(Choru.where('centre_financier = ?  AND date >= ? AND date < ?', params[:id]),@date, @date + 1.year ))
    end
    
    @bop = Choru.where('centre_financier = ?', params[:bop_id]).order('date ASC')
    @uo_search = @bop.first.centre_financier + '-'
    @uos = Choru.where('centre_financier like ?', '%'+@uo_search+'%' ).order('date ASC')
    @uo_arr = []
    @uos.each do |uo|
      @uo_arr << uo.centre_financier
    end 
    @uo_arr.uniq! 
    @uo_ht2 = @uo.where("compte_budgetaire = ? OR (compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?  AND compte_budgetaire != ?)  ", "HT2", "21","22","23","24","25","26").order('date ASC')
    @uo_t2 = @uo.where("compte_budgetaire = ? OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ?  OR compte_budgetaire = ? ", "T2", "21","22","23","24","25","26").order('date ASC')
    
    #nombre d'actions 
    @uo_actions = []
    @uo.where.not(domaine_fonctionnel: nil).each do |uo|
      @uo_actions << uo.domaine_fonctionnel
    end 
    @uo_actions.uniq!
    @uo_action = @uo_actions[0]
    
  end 

  def select_action
    @dates = params[:date]
    #@uo = Choru.where('centre_financier = ?', params[:uo_id]).order('date ASC')
    @uo = Choru.where('date = ?', Date.new(1000))
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1)
      @uo = @uo.or(Choru.where('centre_financier = ?  AND date >= ? AND date < ?', params[:uo_id],@date, @date + 1.year ))
    end
    #nombre d'actions 
    @uo_actions = []
    @uo.where.not(domaine_fonctionnel: nil).each do |uo|
      @uo_actions << uo.domaine_fonctionnel
    end 
    @uo_actions.uniq!
    @uo_action = params[:id]
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
      params.require(:choru).permit(:date, :type_piece, :type_budget, :operation, :centre_financier, :compte_budgetaire, :montant, :domaine_fonctionnel)
    end

end
