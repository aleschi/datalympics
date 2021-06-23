class InnovationsController < ApplicationController
before_action :authenticate_user!
	def index
		@nav=true
	    @q = Innovation.all.ransack(params[:q])
	   
	   	@ouvrages_ids = Innovation.all.pluck(:ouvrage_id).uniq!
	    @ouvrages = Ouvrage.where(id: @ouvrages_ids)
	    @innovations = Innovation.all

	    if params[:term]
        @projets = Innovation.where('nom like ?', "%#{params[:term]}%")
        
        render json: @projets.map(&:nom)  
      	end

      	@arr=[]
      	@ouvrages.each do |ouvrage|
      		@arr << ouvrage.innovations.sum('dotation')
      	end 
      	@maxarr = @arr.max

	end 

	def new
		@innovation = Innovation.new
	end 

	def import
    	Innovation.import(params[:file])
    	redirect_to innovations_path   
  	end

  	def import2
    	Echeancierinnovation.import(params[:file])
    	redirect_to innovations_path  
  	end

  	def import_categorie
    	Typeinnovation.import(params[:file])
    	redirect_to innovations_path  
  	end
  	def new_categorie
  	end

  	def search 
  	@ouvrages = Ouvrage.all

    @projets = Innovation.all
    @q = @projets.ransack(params[:q])
    @projets = @q.result

    @ouvrages_ids =[]
    @projets.each do |projet|
    @ouvrages_ids << projet.ouvrage_id
	end
	@ouvrages = Ouvrage.where(id: @ouvrages_ids)
    
    respond_to do |format|

     format.js

    end
  end 

	def create
	end 

	def edit
    @innovation =  Innovation.find(params[:id]) 
    if @innovation.typeinnovations.where('categorie = ?', "Excellence environnementale").count > 0
      @catenv = true 
    else
      @catenv = false 
    end
    if @innovation.typeinnovations.where('categorie = ?', "Innovation technologique").count > 0
      @cattec = true 
    else
      @cattec = false 
    end
    if @innovation.typeinnovations.where('categorie = ?', "Accessibilité").count > 0
      @catacc = true 
    else
      @catacc = false 
    end
    render partial: 'innovations/form' 
	end

  def form_edit
    @innovation = Innovation.find(params[:id])
    @innovation.nom = params[:nom]
    @innovation.porteur = params[:porteur]
    @innovation.dotation = params[:dotation]
    @innovation.description = params[:description]
    @innovation.save
    if !params[:categories].nil? 
      params[:categories].each do |result|
      if @innovation.typeinnovations.where('categorie = ?',result).count == 0 
        @typeinnov = @innovation.typeinnovations.new
        @typeinnov.categorie = result 
        @typeinnov.save
      end  
      end   
    end

    if params[:categories].nil? || !params[:categories].include?("Excellence environnementale")
       if @innovation.typeinnovations.where('categorie = ?',"Excellence environnementale").count > 0
        @innovation.typeinnovations.where('categorie = ?',"Excellence environnementale").destroy_all
      end
    end 
   
    if params[:categories].nil? || !params[:categories].include?("Innovation technologique")
       if @innovation.typeinnovations.where('categorie = ?',"Innovation technologique").count > 0
        @innovation.typeinnovations.where('categorie = ?',"Innovation technologique").destroy_all
      end
    end 

    if params[:categories].nil? || !params[:categories].include?("Accessibilité")
       if @innovation.typeinnovations.where('categorie = ?',"Accessibilité").count > 0
        @innovation.typeinnovations.where('categorie = ?',"Accessibilité").destroy_all
      end
    end 
    

    @echeancier = @innovation.echeancierinnovations.where('date = ?',Date.new(2021,1,1)).first

    if params[:versement_2021].nil?
      @echeancier.versement = false 
      @echeancier.save 
    else 
      @echeancier.versement = true 
      @echeancier.save 
    end 

    redirect_to innovations_path
  end 

	def update
	end 

	def show
	end 

  private

    def innovation_params
      params.require(:innovation).permit(:nom, :porteur, :ouvrage_id, :dotation, :date, :description)
    end

end
