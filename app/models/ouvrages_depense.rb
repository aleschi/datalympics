class OuvragesDepense < ApplicationRecord
  belongs_to :ouvrage
  
  require 'csv'

  def self.import(file,date_year)

      CSV.foreach(file.path) do |row|
        if !row[0].nil? || !row[0].empty?
          @ouvrage = Ouvrage.find_by_name(row[0])
          if !@ouvrage.nil?
            1.upto(29).each do |i|
              if !row[i].nil? 
                if @ouvrage.ouvrages_depenses.where('date = ?', Date.new(2018) + (i*3 - 1).months).count == 0
                  @ouvrage_depense = @ouvrage.ouvrages_depenses.new
                   @ouvrage_depense.date = Date.new(2018) + (i*3 - 1).months
                else
                  @ouvrage_depense = @ouvrage.ouvrages_depenses.where('date = ?', Date.new(2018) + (i*3 - 1).months).first
                end
                @ouvrage_depense.montant = row[i]
                @ouvrage_depense.montant = @ouvrage_depense.montant * 1000
               
                if @ouvrage_depense.montant_prevu.to_i != 0
                 @ouvrage_depense.date_maquette = Date.new(date_year) 
                 @ouvrage_depense.save
                end 
              end  
            end
          end
        end
      end
    end
  
  def self.import2(file,date_year)

      CSV.foreach(file.path) do |row|
        if !row[0].nil? || !row[0].empty?
          @ouvrage = Ouvrage.find_by_name(row[0])
          if !@ouvrage.nil?
            1.upto(29).each do |i|
              if !row[i].nil? 
                if @ouvrage.ouvrages_depenses.where('date = ?', Date.new(2018) + (i*3 - 1).months).count == 0
                  @ouvrage_depense = @ouvrage.ouvrages_depenses.new
                  @ouvrage_depense.date = Date.new(2018) + (i*3 - 1).months
                else
                  @ouvrage_depense = @ouvrage.ouvrages_depenses.where('date = ?', Date.new(2018) + (i*3 - 1).months).first
                end
                @ouvrage_depense.montant_prevu = row[i]
                @ouvrage_depense.montant_prevu = @ouvrage_depense.montant_prevu * 1000
                if @ouvrage_depense.montant_prevu.to_i != 0
                   @ouvrage_depense.date_maquette = Date.new(date_year) 
                @ouvrage_depense.save
                end 
              end  
            end
          end
        end
      end
    end
  
  def self.import3(file,date_year)

      CSV.foreach(file.path) do |row|
        if !row[0].nil? || !row[0].empty?
          @ouvrage = Ouvrage.find_by_name(row[0])
          if !@ouvrage.nil?
            1.upto(29).each do |i|
              if !row[i].nil? 
                if @ouvrage.ouvrages_depenses.where('date = ?', Date.new(2018) + (i*3 - 1).months).count == 0
                  @ouvrage_depense = @ouvrage.ouvrages_depenses.new
                  @ouvrage_depense.date = Date.new(2018) + (i*3 - 1).months
                else
                  @ouvrage_depense = @ouvrage.ouvrages_depenses.where('date = ?', Date.new(2018) + (i*3 - 1).months).first
                end
                @ouvrage_depense.montant_engage = row[i]
                @ouvrage_depense.montant_engage = @ouvrage_depense.montant_engage * 1000
                
                if @ouvrage_depense.montant_prevu.to_i != 0
                   @ouvrage_depense.date_maquette = Date.new(date_year) 
                @ouvrage_depense.save
                end 
              end  
            end
          end
        end
      end
    end
end
