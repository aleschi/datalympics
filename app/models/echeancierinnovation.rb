class Echeancierinnovation < ApplicationRecord
  belongs_to :innovation

  require 'csv'

  def self.import(file)
  	CSV.foreach(file.path) do |row|
  		if !Innovation.find_by_nom(row[0]).nil?
  		@depense = Echeancierinnovation.new
  		@depense.innovation_id = Innovation.find_by_nom(row[0]).id
  		@depense.date = row[1]
  		@depense.montant = row[2]
  		@depense.versement = false
  		if !@depense.innovation_id.nil?
  			@depense.save
  		end
  		end

  	end
  end

end
