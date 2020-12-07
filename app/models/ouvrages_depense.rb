class OuvragesDepense < ApplicationRecord
  belongs_to :ouvrage
  
  require 'csv'

  def self.import(file)

     CSV.foreach(file.path) do |row|
      if !row[0].nil? && !row[0].empty?
        @ouvrage = Ouvrage.find_by_name(row[0])
        
          if !@ouvrage.nil?
        
            1.upto(3).each do |i|
              if !row[i].nil? 
                @ouvrage_depense = @ouvrage.ouvrages_depenses.new
                @ouvrage_depense.date = Date.new(2018,1) + (i-1).years
                @ouvrage_depense.montant = row[i]
               
                if @ouvrage_depense.montant.to_i != 0
                # @ouvrage_depense.date_maquette = Date.new(date_year) 
                 @ouvrage_depense.save
                end 
              end  
            end
          end
        end
      end
    end
  

end
