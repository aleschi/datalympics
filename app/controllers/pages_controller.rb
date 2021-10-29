class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
     @nav=true
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

  end 

  def accessibilite
  end 

  def public
  end

  def interets
    @ouvrages = OuvragesPublic.all
    @disciplines_all = Discipline.all.pluck(:name).uniq!
    

    @q = Discipline.all.ransack(params[:q])
    if params[:term]
        @disciplines = Discipline.where('name like ?', "%#{params[:term]}%")       
        render json: @disciplines.map(&:name).uniq!  
    end
  end

  def search_ouvrages_publics 
    @ouvrages = OuvragesPublic.all
    @q = Discipline.all.ransack(params[:q])
    @disciplines = @q.result
    @ouvrages_id = []
    @disciplines.each do |discipline|
      @ouvrages_id << discipline.ouvrages_public_id
    end
    @ouvrages = OuvragesPublic.where(id: @ouvrages_id)

    if params[:appartenance]
      @ouvrages = OuvragesPublic.where('appartenance = ?',params[:appartenance])
      @active = params[:appartenance]
    end
    if params[:travaux]
      @ouvrages = OuvragesPublic.where('travaux = ?',params[:travaux])
      @active = params[:travaux]
    end  
    
    respond_to do |format|

     format.js

    end
  end 
  
  def impacts
  end 

  def ouvrages_publics_new
  end 
  
  def import_ouvrages_publics
    OuvragesPublic.import(params[:file])
    redirect_to utilisation_budget_path
  end 
  def disciplines_new

  end 
  
  def import_disciplines
    Discipline.import(params[:file])
    redirect_to utilisation_budget_path
  end 


end
