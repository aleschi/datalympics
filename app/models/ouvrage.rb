class Ouvrage < ApplicationRecord
 has_many :ouvrages_financeurs 
 has_many :ouvrages_financements
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path) do |row|
      #Ouvrage.create! row.to_hash
      @ouvrage = Ouvrage.new
      @ouvrage.name = row[0]
      @ouvrage.maitre_oeuvre = row[1]
      @ouvrage.budget = row[2]*1000
      @ouvrage.save
    end

  end
end
