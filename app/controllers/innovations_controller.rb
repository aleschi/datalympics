class InnovationsController < ApplicationController

	def index
		@nav=true
	    @q = Ouvrage.all.ransack(params[:q])
	   
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
    @projets = Innovation.all
    @q = @projets.ransack(params[:q])
    @projets = @q.result
    
    
    respond_to do |format|

     format.js

    end
  end 

	def create
	end 

	def edit 
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
