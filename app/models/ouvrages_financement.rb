class OuvragesFinancement < ApplicationRecord
  belongs_to :ouvrage
  
   require 'csv'

  def self.import(file)
    @financeurs = ["","privé", "Etat", "RIF", "Ville de Paris", "Métropole Grand Paris", "CD92", "D93", "CD78", "EPT Plaine Commune","EPT Terres d'envol", "Ville de Dugny", "Ville du Bourget", "CASQY", "Ville de Marseille"]

    CSV.foreach(file.path) do |row|
      if !row[0].nil? || !row[0].empty?
        @ouvrage = Ouvrage.find_by_name(row[0])
        if !@ouvrage.nil?
          1.upto(14).each do |i|
            if !row[i].nil?
              @ouvrage_financement = @ouvrage.ouvrages_financements.new
              @ouvrage_financement.montant = row[i]
             
              @ouvrage_financement.name = @financeurs[i]
              @ouvrage_financement.save

            end  
          end
        end
      end
    end

  end
end
