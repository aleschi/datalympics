class Innovation < ApplicationRecord
  belongs_to :ouvrage
  has_many :echeancierinnovations
  has_many :typeinnovations
  require 'csv'

  def self.import(file)
  	CSV.foreach(file.path) do |row|
  		if !Ouvrage.find_by_name(row[1]).nil?
  		@innovation = Innovation.new
  		@innovation.nom = row[0]
  		@innovation.ouvrage_id = Ouvrage.find_by_name(row[1]).id
  		@innovation.porteur = row[2]
  		@innovation.dotation = row[3]
  		@innovation.date = row[4]
  		@innovation.description = "description"
  		if !@innovation.ouvrage_id.nil?
  			@innovation.save
  		end
  		end

  	end
  end
end
