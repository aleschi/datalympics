class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:jop2024, :synthese, :reporting]
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
  
  def jop2024
    @nav=true
    @solideo_financements_etat = SolideoFinancement.where("financeur = ? AND date = ?", "Etat", SolideoFinancement.last.date).sum('montant')
    @solideo_financements_prive = SolideoFinancement.where("financeur = ? AND date = ?", "privé", SolideoFinancement.last.date).sum('montant')
    @solideo_financements_collectivites = SolideoFinancement.where("financeur != ? AND financeur != ? AND date = ?", "Etat", "privé", SolideoFinancement.last.date).sum('montant')
  end 

  def innovation
    @nav=true
  end 

  def reporting
  end 
  
  def synthese 
    @binary_pdf = Dhalang::PDF.get_from_url("https://staging-datalympics.herokuapp.com/reporting")  
    send_data(@binary_pdf, filename: 'reporting.pdf', type: 'application/pdf')  
    #redirect_to root_path 
  end 

end
