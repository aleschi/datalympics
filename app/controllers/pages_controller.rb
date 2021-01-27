class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
     @nav=true
    @document = Document.first
    @q = Ouvrage.all.ransack(params[:q])
    @ouvrages = Ouvrage.all
    @maitre_oeuvre = []
    @maitre_oeuvre_all = []
    @array= []
    @ouvrages.all.each do |ouvrage|
      if ouvrage.maitre_oeuvre != "SOLIDEO"
      @maitre_oeuvre << ouvrage.maitre_oeuvre
      end
      @maitre_oeuvre_all << ouvrage.maitre_oeuvre
      @array << ouvrage.name
    end
    @maitre_oeuvre.uniq!
    @maitre_oeuvre_all.uniq!
  end
  


end
