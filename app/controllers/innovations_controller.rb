class InnovationsController < ApplicationController

	def index
		@nav=true
	    @q = Ouvrage.all.ransack(params[:q])
	   
	    @ouvrages = Ouvrage.all
	end 

	def new
		@innovation = Innovation.new
	end 

	def import
    Innovation.import(params[:file])
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
