class ChorusController < ApplicationController

  def index
    @q = Choru.all.ransack(params[:q])
    @chorus = Choru.all 
    if params[:term]
        @chorus = Choru.all.select { |choru| choru.centre_financier.count("-") == 0 }
        @chorus = @chorus.where('centre_financier like ?', "%#{params[:term]}%")
        
        render json: @chorus.map(&:centre_financier)  
      end
  end 
  
  def new
    @choru = Choru.new
  end 
  def new_conso
  
  end 
  
  def import
   Choru.import(params[:file])
    redirect_to chorus_path 
  end
  def import_conso
   Choru.import_conso(params[:file])
    redirect_to chorus_path 
  end
  
  def update 
  end 
  
  def search_choru
    @id = params[:q][:centre_financier_cont]
    redirect_to choru_path(:id => @id)
  end
  
  def select_date_programme
   
  end
  
  def show 
    @search = params[:id]
    @search2 = "0"+params[:id]
    @search3 = params[:id][1..3]
    @date = Date.new(2019,12,31)
    @dates = ['2020']
    if !Choru.where('centre_financier = ? ', @search2).first.nil?
      @search = @search2 #si on a avec 0 on prend celui la 
    elsif !Choru.where('centre_financier = ? ', @search3).first.nil?
      @search = @search3 #si on a avec 0 on prend celui la 
    end 
    if !Choru.where('centre_financier = ? ', @search).first.nil?
      if params[:vision]
      @vision = params[:vision]
      else
      @vision = '2'
      end
      if params[:budget]
      @budget = params[:budget]
      else
      @budget = 'HT2'
      end
       if params[:type_ae]
      @type_ae = params[:type_ae]
      else
      @type_ae = 'cp'
      end

      @chorus = Choru.where('type_ae = ? AND compte_budgetaire = ?',@type_ae, @budget).where('centre_financier like ? ', '%'+@search+'%') #tous les elements de ce programme
      
      if !@chorus.nil?
        @chorus = @chorus.order('date ASC')
        @programme = Choru.where('type_ae = ? AND centre_financier = ? AND date >= ? AND date < ? AND compte_budgetaire = ?',@type_ae, @search, @date, @date + 1.year, @budget)

        @type_pieces=[] 
        if !@programme.nil? && @programme.count > 0
          @programme = @programme.order('date ASC')
          @programme.each do |choru|
            if choru.type_piece != "RB" && choru.type_piece != "LFI"
            @type_pieces << choru.type_piece
            end
          end 
          @type_pieces.uniq! 
          @montant_lfi = @programme.where('type_budget = ? OR type_budget = ?', "Bud. voté ou en cours de vote", "Loi de Finances Initiale").first.montant
          @montant_dispo = @programme.where('type_piece != ? AND type_piece != ?',"MADI",'RB').sum('montant')
          @montant_reserve = @programme.where('type_piece = ?','RB').sum('montant') 
  
          @bops = @chorus.select { |choru| choru.centre_financier.count("-") == 1 } #tous les bops du programme  
          #compter le nombre de bop differents 
          @bop_arr = []
          @bops.each do |bop|
            @bop_arr << bop.centre_financier
          end 
          @bop_arr.uniq!
          @bops_show = [@bop_arr[0]]
          @bop = Choru.where('type_ae = ? AND centre_financier = ? AND date >= ? AND date < ? AND compte_budgetaire = ?',@type_ae, @bop_arr[0],@date, @date + 1.year, @budget).order('date ASC')
          @type_pieces_bop=[]
          if !@bop.nil?
            @bop.each do |choru|
              @type_pieces_bop << choru.type_piece
            end 
            @type_pieces_bop.uniq! 
          end

          #compter le nombre de uo differents du bop selecionne
          @uo_search = @bop.first.centre_financier + '-'
          @uos = Choru.where('type_ae = ? AND compte_budgetaire = ?',@type_ae, @budget).where('centre_financier like ? ', '%'+@uo_search+'%').order('date ASC')
          @uo_arr = []
          @uos.each do |uo|
            @uo_arr << uo.centre_financier
          end 
          @uo_arr.uniq! 
          @uos_show = [@uo_arr[0]]
          @uo = Choru.where('type_ae = ? AND centre_financier = ?  AND date >= ? AND date < ? AND compte_budgetaire = ?',@type_ae, @uo_arr[0],@date, @date + 1.year, @budget ).order('date ASC') #on choisit dafficher le premier uo      
         @type_pieces_uo=[]
          if !@uo.nil?
            @uo.each do |choru|
              @type_pieces_uo << choru.type_piece
            end 
            @type_pieces_uo.uniq! 
          end

         #nombre d'actions 
          @uo_actions = []
          Choru.where('centre_financier = ? AND date >= ? AND date < ?',@uo_arr[0],@date, @date + 1.year).where.not(domaine_fonctionnel: nil).each do |uo|
            @uo_actions << uo.domaine_fonctionnel
          end 
          @uo_actions.uniq!
          @uo_action = @uo_actions[0]
          if !@uo_actions[0].nil?
          @actions_show = [@uo_actions[0]]
          else
            @actions_show = []
          end
          @chorusconso = Chorusconso.where('centre_financier = ? AND action = ?',@uo_arr[0], @uo_action ).order('date ASC')
        end
      end
    else
      redirect_to chorus_path 
    end
  end 

  def select_bop
    @dates = params[:date]
    @vision = params[:vision]
    @budget = params[:budget]
    @type_ae = params[:type_ae]
    #@bop = Choru.where('centre_financier = ?', params[:id]).order('date ASC')
    @bop = Choru.where('date = ?', Date.new(1000))
    @uo = Choru.where('date = ?', Date.new(1000))
    @uos = Choru.where('date = ?', Date.new(1000))
    @search = params[:programme]
    
   
    @bops_show = params[:id]
   
    #on va rassembler tous les elements des bop pour savoir le nombre de piece
    params[:id].each do |id|
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1) 
      @bop = @bop.or(Choru.where('type_ae = ? AND centre_financier = ? AND date >= ? AND date < ? AND compte_budgetaire = ?', @type_ae, id,@date, @date + 1.year, @budget ))
    end
    end
    @type_pieces_bop=[]
      if !@bop.nil?
        @bop.each do |choru|
          @type_pieces_bop<< choru.type_piece
        end 
        @type_pieces_bop.uniq! 
      end
   
    @uo_search = []
    @bops_show.each do |bop|
      @uo_search << bop + '-'
    end
    @uo_search.each do |uo_search|
    @uos = @uos.or(Choru.where('centre_financier like ? ', '%'+uo_search+'%'))
    end
    @uo_arr = []
    @uos.each do |uo|
      @uo_arr << uo.centre_financier
    end 
    @uo_arr.uniq! #toutes les uo des bop
    @uos_show = [@uo_arr[0]] #on affiche que la premiere
  
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1)
      @uo = @uo.or(Choru.where('type_ae = ? AND centre_financier = ?  AND date >= ? AND date < ? AND compte_budgetaire = ?',@type_ae, @uo_arr[0],@date, @date + 1.year, @budget ))
    end
    @uo = @uo.order('date ASC')
    @type_pieces_uo=[]
      if !@uo.nil?
        @uo.each do |choru|
          @type_pieces_uo << choru.type_piece
        end 
        @type_pieces_uo.uniq! 
      end
     
    #nombre d'actions 
      @uo_actions = []
      Choru.where('centre_financier = ? AND date >= ? AND date < ?', @uo_arr[0],@date, @date + 1.year).where.not(domaine_fonctionnel: nil).each do |uo|
        @uo_actions << uo.domaine_fonctionnel
      end 
      @uo_actions.uniq!
      @uo_action = @uo_actions[0]
      if !@uo_actions[0].nil?
      @actions_show = [@uo_actions[0]]
      else
        @actions_show = []
      end
    @chorusconso = Chorusconso.where('centre_financier = ? AND action = ?',@uo_arr[0], @uo_action ).order('date ASC')
  end 
  
  def select_uo
    @dates = params[:date]
    @budget = params[:budget]
    @uo = Choru.where('date = ?', Date.new(1000))
    @uos = Choru.where('date = ?', Date.new(1000))
    @bops_show = params[:bop_id] 
    @search = params[:programme]
    @type_ae = params[:type_ae]
    @uo_search = []
    @bops_show.each do |bop|
      @uo_search << bop + '-'
    end
    @uo_search.each do |uo_search|
    @uos = @uos.or(Choru.where('centre_financier like ? ', '%'+uo_search+'%'))
    end
    @uo_arr = []
    @uos.each do |uo|
      @uo_arr << uo.centre_financier
    end 
    @uo_arr.uniq! #toutes les uo des bops
   
    @uos_show = params[:id]
   
    @uos_show.each do |uo|
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1)
      @uo = @uo.or(Choru.where('type_ae = ? AND centre_financier = ?  AND date >= ? AND date < ? AND compte_budgetaire = ?',@type_ae, uo,@date, @date + 1.year, @budget ))
    end
    end
    @uo = @uo.order('date ASC')
    
    @type_pieces_uo=[]
      if !@uo.nil?
        @uo.each do |choru|
          @type_pieces_uo << choru.type_piece
        end 
        @type_pieces_uo.uniq! 
      end
     
    #nombre d'actions 
      @uo_actions = []
      @uos_show.each do |uo_show|
      Choru.where('centre_financier = ? AND date >= ? AND date < ?',uo_show,@date, @date + 1.year).where.not(domaine_fonctionnel: nil).each do |uo|
        @uo_actions << uo.domaine_fonctionnel
      end 
      end
      @uo_actions.uniq!
      @uo_action = @uo_actions[0]
      if !@uo_actions[0].nil?
      @actions_show = [@uo_actions[0]]
      else
        @actions_show = []
      end
    @chorusconso = Chorusconso.where('centre_financier = ? AND action = ?',@uo.first.centre_financier, @uo_action ).order('date ASC')
    
  end 

  def select_action
    @dates = params[:date]
    @budget = params[:budget]
    @uos_show = params[:uo_id]
    @search = params[:programme]
    @uo = Choru.where('date = ?', Date.new(1000))
    @uos_show.each do |uo|
    params[:date].each do |date|
      @date = Date.new(date.to_i-1,12,1)
      @uo = @uo.or(Choru.where('centre_financier = ?  AND date >= ? AND date < ? AND compte_budgetaire = ?', uo,@date, @date + 1.year, @budget ))
    end
    end
    @uo = @uo.order('date ASC')
    #nombre d'actions 
     @uo_actions = []
      @uos_show.each do |uo_show|
      Choru.where('centre_financier = ? AND date >= ? AND date < ?',uo_show,@date, @date + 1.year).where.not(domaine_fonctionnel: nil).each do |uo|
        @uo_actions << uo.domaine_fonctionnel
      end 
      end
      @uo_actions.uniq!
    @uo_action = @uo_actions[0]
    @actions_show = params[:id]
    @chorusconso = Chorusconso.where('centre_financier = ? AND action = ?',@uo.first.centre_financier, @uo_action ).order('date ASC')
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
