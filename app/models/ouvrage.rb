class Ouvrage < ApplicationRecord

 has_many :ouvrages_financements, dependent: :destroy
  has_many :ouvrages_depenses, dependent: :destroy
  has_many :chantiers, dependent: :destroy 
  geocoded_by :adresse
  after_validation :geocode
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path) do |row|
      #Ouvrage.create! row.to_hash
      if Ouvrage.find_by_name(row[0]).nil?
        @ouvrage = Ouvrage.new
      else
        @ouvrage = Ouvrage.find_by_name(row[0])
      end 
      @ouvrage.name = row[0]
      @ouvrage.maitre_oeuvre = row[1]
      @ouvrage.budget = row[2]
      @ouvrage.budget = @ouvrage.budget * 1000
      @ouvrage.adresse = row[3]
      @ouvrage.save
    end

  end
  
    has_one_attached :photo, dependent: :destroy
end
