class EtatDepense < ApplicationRecord
   require 'csv'
  
  def self.import(file)
    CSV.foreach(file.path) do |row| 
      if row[2] == "0350-01" 
        if !row[6].nil? && !row[9].nil?
        @etat_depense = EtatDepense.new
        @etat_depense.categorie = row[3]
        @etat_depense.date = row[4]
        @etat_depense.ae_conso = row[6]
        @etat_depense.cp_conso = row[9]
        #manque cp prevu et ae prevu 
        end
      end
    end
  end #end def 
  
end
