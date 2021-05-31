class InnovationsController < ApplicationController

	def index
		@nav=true
	    @q = Ouvrage.all.ransack(params[:q])
	   
	   @ouvrages_ids = Innovation.all.pluck(:ouvrage_id).uniq!
	    @ouvrages = Ouvrage.where(id: @ouvrages_ids)
	    @innovations = Innovation.all


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
