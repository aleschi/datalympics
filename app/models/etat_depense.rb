class EtatDepense < ApplicationRecord
   require 'csv'
  
  def self.import(file)
    CSV.foreach(file.path) do |row| 
      @etat_depense = EtatDepense.new
    end
  end #end def 
  
end
