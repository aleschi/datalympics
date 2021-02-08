class Maquette < ApplicationRecord
  require 'csv'
   def self.import(file)
    CSV.foreach(file.path) do |row|
      if !row[0].nil? && !row[0].empty?
      @maquette = Maquette.new
      @maquette.name = row[0]
        if row[1] == "oui"
          if Ouvrage.find_by_name(row[0])
          @maquette.ouvrage_id = Ouvrage.find_by_name(row[0]).id
          end
        end
      @maquette.total = row[2]
        if !@maquette.total.nil?
          @maquette.total = @maquette.total * 1000
        else 
         @maquette.total = 0
        end 
      @maquette.total_complementaire = row[3]
        if !@maquette.total_complementaire.nil?
          @maquette.total_complementaire = @maquette.total_complementaire * 1000
        else 
           @maquette.total_complementaire = 0
        end 
      @maquette.total_public = row[4]
        if !@maquette.total_public.nil?
          @maquette.total_public = @maquette.total_public * 1000
        else 
          @maquette.total_public = 0
        end 
      @maquette.date = row[5]
      @maquette.commentaire = row[6]
      @maquette.save 
        if @maquette.date.nil?
          @maquette.destroy 
        end
 
      end
    end
  end
end
