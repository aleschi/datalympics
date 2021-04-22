class Chantier < ApplicationRecord
  #belongs_to :ouvrage
  require 'csv'
   def self.import(file,date)
    CSV.foreach(file.path) do |row|
      
    	@chantier = Chantier.new
    	@chantier.code = row[0]
    	@chantier.site = row[1]
    	@chantier.name = row[2]
    	@chantier.libelle = row[2]
    	@chantier.typecontrat = row[3]
    	@chantier.datesignature = row[4]
    	@chantier.total_depenses_actees = row[5].to_f/100
    	@chantier.depenses_actees_annee = row[6].to_f/100
    	@chantier.jalons_annee = row[7].to_f/100
    	@chantier.paiements_annee = row[8].to_f/100
    	@chantier.paiements_attente_annee = row[9].to_f/100
    	@chantier.budget_annee = row[10].to_f/100
    	@chantier.cumul_depenses_actees = row[11].to_f/100
    	@chantier.cumul_jalons = row[12].to_f/100
    	@chantier.cumul_paiements = row[13].to_f/100
    	@chantier.date = date
    	if @chantier.depenses_actees_annee.nil?
    		@chantier.depenses_actees_annee = 0 
    	end 
    	if @chantier.jalons_annee.nil?
    		@chantier.jalons_annee = 0 
    	end 
    	if @chantier.paiements_annee.nil?
    		@chantier.paiements_annee = 0 
    	end 
    	if @chantier.paiements_attente_annee.nil?
    		@chantier.paiements_attente_annee = 0 
    	end 
    	if @chantier.budget_annee.nil?
    		@chantier.budget_annee = 0 
    	end 
    	if @chantier.cumul_depenses_actees.nil?
    		@chantier.cumul_depenses_actees = 0 
    	end 
    	if @chantier.cumul_jalons.nil?
    		@chantier.cumul_jalons = 0 
    	end 
    	if @chantier.cumul_paiements.nil?
    		@chantier.cumul_paiements = 0 
    	end 
      	@chantier.save
    end

  end
end
