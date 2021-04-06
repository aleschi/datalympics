class ChorusNomenclature < ApplicationRecord
	require 'csv'
  
    def self.import(file)
    	CSV.foreach(file.path) do |row|
      		if !row[0].nil? && !row[0].empty?
      			@chorus_nom = ChorusNomenclature.new
      			@chorus_nom.nom = row[0]
      			@chorus_nom.designation = row[1]
      			@chorus_nom.save
      			
      		end
  		end
	end
end
