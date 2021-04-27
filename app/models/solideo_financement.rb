class SolideoFinancement < ApplicationRecord
  require 'csv'
  
  def self.import(file)
    CSV.foreach(file.path) do |row|
      @solideofinancement=SolideoFinancement.new
      @solideofinancement.financeur = row[0]
      @solideofinancement.montant = row[1]
      @solideofinancement.date = row[2]
      if !@solideofinancement.montant.nil?
        @solideofinancement.save
      end 
    end 
  end
  
  def self.import2(file, date_year, date_month)
    @financeurs = ["","privé", "Etat", "RIF", "Ville de Paris", "Métropole Grand Paris", "CD92", "CD93", "CD78", "EPT Plaine Commune","EPT Terres d'envol", "Ville de Dugny", "Ville du Bourget", "CASQY", "Ville de Marseille"]
  end
end
