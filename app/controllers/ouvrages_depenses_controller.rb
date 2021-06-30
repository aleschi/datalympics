class OuvragesDepensesController < ApplicationController
  before_action :set_ouvrages_depense, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /ouvrages_depenses
  # GET /ouvrages_depenses.json
  def index 
    @nav=true
    @ouvrages = Ouvrage.all
    @dates_maquettes= Maquette.order('date DESC').pluck(:date).uniq! 
    @dates_maquettes_o= Maquette.order('date DESC').pluck(:date).uniq! 

    @maquette_ouvrages = Maquette.where('name != ? AND name != ? AND name != ? AND name != ? AND name != ? AND name != ? AND name != ? AND name != ?','CPJ','Réserve pour compléments de programme','Paris Fonds Vert','Fonds Innovation et Développement Durable','Frais de Structure SOLIDEO','Voies Olympiques [Réserve]',"Stade de France [Pertes d'exploitation]","Sites d'entrainement (non affectés)").where.not('name like ?', "%SITE d'ENTRAINEMENT%").pluck(:name).uniq!

    @maquette_budget_nouveau = 0
    @maquette_ouvrages.each do |name|
      if Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public.to_i == 0 && Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public.to_i != 0
        @maquette_budget_nouveau = @maquette_budget_nouveau + Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public 
      end
    end 
      
    @maquette_budget_augmentation = 0 
    @maquette_ouvrages.each do |name|
        if Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public != 0 && Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public < Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public
          @maquette_budget_augmentation = @maquette_budget_augmentation + Maquette.where('name = ? AND date = ?', name,@dates_maquettes[0]).first.total_public - Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public
        end 
      end 
          
     @maquette_budget_diminution = 0
     @maquette_ouvrages.each do |name|
          if  Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public != 0 && Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public > Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public
          @maquette_budget_diminution = @maquette_budget_diminution + Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public - Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public
        end 
     end
    @maquette_budget_diminution = @maquette_budget_diminution -Maquette.where('name = ? AND date = ?', "Stade de France [Pertes d'exploitation]", @dates_maquettes[@dates_maquettes.length-1]).first.total_public + Maquette.where('name = ? AND date = ?', "Stade de France [Pertes d'exploitation]", @dates_maquettes[0]).first.total_public
    @maquette_budget_diminution = @maquette_budget_diminution -Maquette.where('name = ? AND date = ?', "Voies Olympiques [Réserve]", @dates_maquettes[@dates_maquettes.length-1]).first.total_public + Maquette.where('name = ? AND date = ?', "Voies Olympiques [Réserve]", @dates_maquettes[0]).first.total_public
    @maquette_budget_diminution = @maquette_budget_diminution - Maquette.where('name = ? AND date = ?', "CPJ", @dates_maquettes[@dates_maquettes.length-1]).first.total_public + Maquette.where('name = ? AND date = ?', "CPJ",@dates_maquettes[0]).first.total_public
            
    @maquette_ecart_reserve = 0
    @reserve_name = Maquette.where('name = ? OR name = ? OR name = ?', 'Réserve pour compléments de programme', 'Paris Fonds Vert', 'Fonds Innovation et Développement Durable').pluck(:name).uniq!
  
          
     @reserve_name.each do |name|
       if !Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.nil?
       @maquette_ecart_reserve = @maquette_ecart_reserve + Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public - Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public
       end
     end
            
  end

  def maquette_date
    @dates_maquettes= Maquette.order('date DESC').pluck(:date).uniq! 
    @dates_maquettes_o= Maquette.order('date DESC').pluck(:date).uniq! 
  

    @maquette_ouvrages = Maquette.where('name != ? AND name != ? AND name != ? AND name != ? AND name != ? AND name != ? AND name != ? AND name != ?','CPJ','Réserve pour compléments de programme','Paris Fonds Vert','Fonds Innovation et Développement Durable','Frais de Structure SOLIDEO','Voies Olympiques [Réserve]',"Stade de France [Pertes d'exploitation]","Sites d'entrainement (non affectés)").where.not('name like ?', "%SITE d'ENTRAINEMENT%").pluck(:name).uniq!

    @dates_maquettes[0]= params[:date].to_date
    @maquette_budget_nouveau = 0
    @maquette_ouvrages.each do |name|
      if Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public.to_i == 0 && Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public.to_i != 0
        @maquette_budget_nouveau = @maquette_budget_nouveau + Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public 
      end
    end 
      
    @maquette_budget_augmentation = 0 
    @maquette_ouvrages.each do |name|
        if Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public != 0 && Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public < Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public
          @maquette_budget_augmentation = @maquette_budget_augmentation + Maquette.where('name = ? AND date = ?', name,@dates_maquettes[0]).first.total_public - Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public
        end 
      end 
          
     @maquette_budget_diminution = 0
     @maquette_ouvrages.each do |name|
          if  Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public != 0 && Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public > Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public
          @maquette_budget_diminution = @maquette_budget_diminution + Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public - Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public
        end 
     end
    @maquette_budget_diminution = @maquette_budget_diminution -Maquette.where('name = ? AND date = ?', "Stade de France [Pertes d'exploitation]", @dates_maquettes[@dates_maquettes.length-1]).first.total_public + Maquette.where('name = ? AND date = ?', "Stade de France [Pertes d'exploitation]", @dates_maquettes[0]).first.total_public
    @maquette_budget_diminution = @maquette_budget_diminution -Maquette.where('name = ? AND date = ?', "Voies Olympiques [Réserve]", @dates_maquettes[@dates_maquettes.length-1]).first.total_public + Maquette.where('name = ? AND date = ?', "Voies Olympiques [Réserve]", @dates_maquettes[0]).first.total_public
    @maquette_budget_diminution = @maquette_budget_diminution - Maquette.where('name = ? AND date = ?', "CPJ", @dates_maquettes[@dates_maquettes.length-1]).first.total_public + Maquette.where('name = ? AND date = ?', "CPJ",@dates_maquettes[0]).first.total_public
            
     @maquette_ecart_reserve = 0
     @reserve_name = []  
     Maquette.where('name = ? OR name = ? OR name = ?', 'Réserve pour compléments de programme', 'Paris Fonds Vert', 'Fonds Innovation et Développement Durable').each do |maquette|
      @reserve_name << maquette.name
     end
     @reserve_name.uniq!
          
     @reserve_name.each do |name|
       if !Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.nil?
       @maquette_ecart_reserve = @maquette_ecart_reserve + Maquette.where('name = ? AND date = ?', name, @dates_maquettes[0]).first.total_public - Maquette.where('name = ? AND date = ?', name, @dates_maquettes[@dates_maquettes.length-1]).first.total_public
       end
     end

    respond_to :js
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
  
  def import
    OuvragesDepense.all.destroy_all
    
    OuvragesDepense.import(params[:file])

    redirect_to ouvrages_depenses_path
  end 
  
  def import_maquette
    Maquette.import(params[:file])
    redirect_to ouvrages_depenses_path
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
      params.require(:ouvrages_depense).permit(:date, :ouvrage_id, :name, :montant, :montant_prevu, :montant_engage, :date_maquette)
    end
end
