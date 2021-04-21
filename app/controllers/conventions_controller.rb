class ConventionsController < ApplicationController

  before_action :authenticate_user!

  def index
      @nav=true
      @conventions = Convention.all
  end 
  def new
    @convention = Convention.new
  end 
  
  def create
    @convention = Convention.new(convention_params)
    respond_to do |format|
      if @convention.save
        format.html { redirect_to conventions_path }
      else
        format.html { render :new }
      end
    end
  end 
  
  def edit
    @convention= Convention.find(params[:id])
    
    respond_to :js 
  end 
  
  def update
     @convention.update(convention_params)
     redirect_back(fallback_location: root_path)
  
  end 
  
  def destroy
    @convention.destroy
    
    respond_to :js 
  end
  


 
  
    private
  

    # Only allow a list of trusted parameters through.
    def convention_params
      params.require(:convention).permit(:date, :travaux_signature, :objectifs_signature, :etudes_signature, :objectifs_encours, :avenants_objectifs_encours, :avenants_travaux_encours, :protocole_etudes_encours, :objectifs_elaboration)
    end
end