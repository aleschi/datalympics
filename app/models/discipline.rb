class Discipline < ApplicationRecord
  belongs_to :ouvrages_public
	require 'csv'

  def self.import(file)
  	CSV.foreach(file.path) do |row|
  		if !OuvragesPublic.find_by_nom(row[1]).nil? 
  		@discipline = Discipline.new
  		@discipline.name = row[0]
  		@discipline.epreuves = row[2]
  		@discipline.ouvrages_public_id = OuvragesPublic.find_by_nom(row[1]).id
  		@discipline.save 
  		end
  	end 
  end
end
