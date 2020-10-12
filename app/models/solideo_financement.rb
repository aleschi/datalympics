class SolideoFinancement < ApplicationRecord
  require 'csv'
  
  def self.import(file, date_year, date_month)
    @financeurs = ["","privé", "Etat", "RIF", "Ville de Paris", "Métropole Grand Paris", "CD92", "CD93", "CD78", "EPT Plaine Commune","EPT Terres d'envol", "Ville de Dugny", "Ville du Bourget", "CASQY", "Ville de Marseille"]

    CSV.foreach(file.path) do |row|
      #Ouvrage.create! row.to_hash
       if row[0] == "RESERVE"
         1.upto(14).each do |i|
            if !row[i].nil? 
              @solideo_financement = SolideoFinancement.new
              @solideo_financement.montant_prevu = row[i]
              @solideo_financement.montant_prevu = @solideo_financement.montant_prevu * 1000
              @solideo_financement.financeur = @financeurs[i]
              @solideo_financement.categorie = "reserve"
              @solideo_financement.date = DateTime.new(date_year, date_month)
              if @solideo_financement.montant_prevu.to_i != 0
              @solideo_financement.save
              end 
            end
          end  
       elsif row[0] == "FONDS INNOVATION ET DD"
          1.upto(14).each do |i|
            if !row[i].nil? 
              @solideo_financement = SolideoFinancement.new
              @solideo_financement.montant_prevu = row[i]
              @solideo_financement.montant_prevu = @solideo_financement.montant_prevu * 1000
              @solideo_financement.financeur = @financeurs[i]
              @solideo_financement.categorie = "innovation"
              @solideo_financement.date = DateTime.new(date_year, date_month)
              if @solideo_financement.montant_prevu.to_i != 0
              @solideo_financement.save
              end 
            end
          end  
       elsif row[0] == "frais SOLIDEO"
          1.upto(14).each do |i|
            if !row[i].nil? 
              @solideo_financement = SolideoFinancement.new
              @solideo_financement.montant_prevu = row[i]
              @solideo_financement.montant_prevu = @solideo_financement.montant_prevu * 1000
              @solideo_financement.financeur = @financeurs[i]
              @solideo_financement.categorie = "fonctionnement"
              @solideo_financement.date = DateTime.new(date_year, date_month)
              if @solideo_financement.montant_prevu.to_i != 0
              @solideo_financement.save
              end
            end
          end  
       elsif row[0] == "Total ouvrages"
        1.upto(14).each do |i|
            if !row[i].nil? 
              @solideo_financement = SolideoFinancement.new
              @solideo_financement.montant_prevu = row[i]
              @solideo_financement.montant_prevu = @solideo_financement.montant_prevu * 1000
              @solideo_financement.financeur = @financeurs[i]
              @solideo_financement.categorie = "ouvrages"
              @solideo_financement.date = DateTime.new(date_year, date_month)
              if @solideo_financement.montant_prevu.to_i != 0
              @solideo_financement.save
              end 
            end
          end  
       end
    end

  end
  
  def self.import2(file, date_year, date_month)
    @financeurs = ["","privé", "Etat", "RIF", "Ville de Paris", "Métropole Grand Paris", "CD92", "CD93", "CD78", "EPT Plaine Commune","EPT Terres d'envol", "Ville de Dugny", "Ville du Bourget", "CASQY", "Ville de Marseille"]

    CSV.foreach(file.path) do |row|
      #Ouvrage.create! row.to_hash
      if row[0] == "RESERVE"
         1.upto(14).each do |i|
            if !row[i].nil? 
              @solideo_financement = SolideoFinancement.where('financeur = ? AND categorie = ? AND date = ?', @financeurs[i], "reserve", Date.new(date_year, date_month)).first 
              if !@solideo_financement.nil?
                @solideo_financement.montant = row[i]
                @solideo_financement.montant = @solideo_financement.montant * 1000

                if @solideo_financement.montant.to_i != 0
                @solideo_financement.save
                end
              else
                @solideo_financement = SolideoFinancement.new
                @solideo_financement.financeur = @financeurs[i]
                @solideo_financement.categorie = "reserve"
                @solideo_financement.date = DateTime.new(date_year, date_month)
                @solideo_financement.montant_prevu = 0
                @solideo_financement.montant = row[i]
                @solideo_financement.montant = @solideo_financement.montant * 1000

                if @solideo_financement.montant.to_i != 0
                @solideo_financement.save
                end
              end
            end
          end  
       elsif row[0] == "FONDS INNOVATION ET DD"
          1.upto(14).each do |i|
            if !row[i].nil? 
              @solideo_financement = SolideoFinancement.where('financeur = ? AND categorie = ? AND date = ?', @financeurs[i], "innovation", Date.new(date_year, date_month)).first 
              if !@solideo_financement.nil?
                @solideo_financement.montant = row[i]
                @solideo_financement.montant = @solideo_financement.montant * 1000

                if @solideo_financement.montant.to_i != 0
                @solideo_financement.save
                end
              else
                @solideo_financement = SolideoFinancement.new
                @solideo_financement.financeur = @financeurs[i]
                @solideo_financement.categorie = "innovation"
                @solideo_financement.date = DateTime.new(date_year, date_month)
                @solideo_financement.montant_prevu = 0
                @solideo_financement.montant = row[i]
                @solideo_financement.montant = @solideo_financement.montant * 1000

                if @solideo_financement.montant.to_i != 0
                @solideo_financement.save
                end
              end
            end
          end  
       elsif row[0] == "frais SOLIDEO"
          1.upto(14).each do |i|
            if !row[i].nil? 
              @solideo_financement = SolideoFinancement.where('financeur = ? AND categorie = ? AND date = ?', @financeurs[i],"fonctionnement", Date.new(date_year, date_month)).first 
             if !@solideo_financement.nil?
                @solideo_financement.montant = row[i]
                @solideo_financement.montant = @solideo_financement.montant * 1000

                if @solideo_financement.montant.to_i != 0
                @solideo_financement.save
                end
             else
                @solideo_financement = SolideoFinancement.new
                @solideo_financement.financeur = @financeurs[i]
                @solideo_financement.categorie = "fonctionnement"
                @solideo_financement.date = DateTime.new(date_year, date_month)
                @solideo_financement.montant_prevu = 0
                @solideo_financement.montant = row[i]
                @solideo_financement.montant = @solideo_financement.montant * 1000

                if @solideo_financement.montant.to_i != 0
                @solideo_financement.save
                end
              end
            end
          end  
       elsif row[0] == "Total ouvrages"
          1.upto(14).each do |i|
            if !row[i].nil? 
              @solideo_financement = SolideoFinancement.where('financeur = ? AND categorie = ? AND date = ? ', @financeurs[i], "ouvrages", Date.new(date_year, date_month)).first 
              if !@solideo_financement.nil?
                @solideo_financement.montant = row[i]
                @solideo_financement.montant = @solideo_financement.montant * 1000

                if @solideo_financement.montant.to_i != 0
                @solideo_financement.save
                end
              else
                @solideo_financement = SolideoFinancement.new
                @solideo_financement.financeur = @financeurs[i]
                @solideo_financement.categorie = "ouvrages"
                @solideo_financement.date = DateTime.new(date_year, date_month)
                @solideo_financement.montant_prevu = 0
                @solideo_financement.montant = row[i]
                @solideo_financement.montant = @solideo_financement.montant * 1000

                if @solideo_financement.montant.to_i != 0
                @solideo_financement.save
                end
              end
            end
          end
        end
    end
  end
end
