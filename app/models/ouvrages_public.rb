class OuvragesPublic < ApplicationRecord
  has_many :disciplines
	geocoded_by :adresse
  after_validation :geocode
  require 'csv'

  def self.import(file)
  	CSV.foreach(file.path) do |row|
  		if !row[0].nil? && !row[0].empty?
  		@ouvrage = OuvragesPublic.new
  		@ouvrage.nom = row[0]
  		@ouvrage.adresse = row[1]
  		@ouvrage.travaux = row[2]
  		@ouvrage.appartenance = row[3]
  		if !Ouvrage.find_by_name(row[0]).nil?
  		@ouvrage.ouvrage_id = Ouvrage.find_by_name(row[0]).id 
  		end 
  		@ouvrage.save
  		end
  	end 
  end
end
