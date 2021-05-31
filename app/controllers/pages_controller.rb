class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]
  def home
     @nav=true
    @document = Document.first

    @dates_ouvrages_reporting = Chantier.order('date DESC').pluck(:date).uniq!
    @ouvrages_depenses_2021 = (Chantier.where('date = ?',@dates_ouvrages_reporting[0]).sum('paiements_annee')/1000000).round(1)
    @ouvrages_budget_2021 = (Chantier.where('date = ?',@dates_ouvrages_reporting[0]).sum('budget_annee')/1000000).round(1)
    @ouvrages_budget_global = (Chantier.where('date = ?',@dates_ouvrages_reporting[0]).sum('total_depenses_actees')/1000000).round(1)
    @ouvrages_depenses_global = (Chantier.where('date = ?',@dates_ouvrages_reporting[0]).sum('cumul_paiements')/1000000).round(1)
    @ouvrages_depenses_attente = (Chantier.where('date = ?',@dates_ouvrages_reporting[0]).sum('paiements_attente_annee')/1000000).round(1)

    @dates_maquettes= Maquette.order('date DESC').pluck(:date).uniq! 
    @budget_ouvrages = (Maquette.where('date = ?',@dates_maquettes[0]).where.not(ouvrage_id: nil).sum('total')/1000000).to_i 
  end
  
  def jop2024
    @nav=true
    @solideo_financements_etat = SolideoFinancement.where("financeur = ? AND date = ?", "Etat", SolideoFinancement.last.date).sum('montant')
    @solideo_financements_prive = SolideoFinancement.where("financeur = ? AND date = ?", "privé", SolideoFinancement.last.date).sum('montant')
    @solideo_financements_collectivites = SolideoFinancement.where("financeur != ? AND financeur != ? AND date = ?", "Etat", "privé", SolideoFinancement.last.date).sum('montant')
  end 



  def reporting
  end 
  
  def synthese 
    #@binary_pdf = Dhalang::PDF.get_from_url("https://staging-datalympics.herokuapp.com/reporting")  
    @binary_pdf = Dhalang::PDF.get_from_url("http://localhost:3000/reporting", {navigationTimeout: 200000}) 
    send_data(@binary_pdf, filename: 'reporting.pdf', type: 'application/pdf')  
    #redirect_to root_path 

  
  end 

  def mentions
  @nav=true 
  end 

  def public
  end

  def interets
    @ouvrages = Ouvrage.all
  end 
  
  def acteurs
  end 

end
