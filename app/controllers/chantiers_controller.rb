class ChantiersController < ApplicationController
  before_action :set_chantier, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @nav = true
  end
  
  def show
    @nav = true
    @navshow = true 
    @ouvrage = @chantier.ouvrage 
  end 
  
  def new 
  end 
  
  def edit 
  end 
  
  def update
  end
  
  def destroy
  end 
  
  private
  
  def set_chantier
      @chantier = Chantier.find(params[:id])
    end

    def chantier_params
      params.require(:chantier).permit(:name, :ouvrage_id)
    end

end
