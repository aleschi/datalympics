class Typeinnovation < ApplicationRecord
  belongs_to :innovation

  require 'csv'

  def self.import(file)
  	CSV.foreach(file.path) do |row|
  		if !Innovation.find_by_nom(row[0]).nil?
  		@type = Typeinnovation.new
  		@type.innovation_id = Innovation.find_by_nom(row[0]).id
  		@type.categorie = row[1]

  		if !@type.innovation_id.nil?
  			@type.save
  		end
  		end

  	end
  end
end
