class Ouvrage < ApplicationRecord

 has_many :ouvrages_financements, dependent: :destroy
  has_many :ouvrages_depenses, dependent: :destroy
  has_many :chantiers, dependent: :destroy 
  has_many :ouvrages_revues, dependent: :destroy 
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
      @ouvrage.adresse = row[1]
      @ouvrage.maitre_oeuvre = row[2]
      @ouvrage.budget = row[3]
      if !@ouvrage.budget.nil?
        @ouvrage.budget = @ouvrage.budget * 1000
      else 
        @ouvrage.budget = 0
      end
      @ouvrage.description = row[4]
      @ouvrage.heritage = row[5]
      @ouvrage.start = row[6]
      @ouvrage.end = row[7]
      @ouvrage.save
    end

  end
  def self.update_file(file)
    CSV.foreach(file.path) do |row|
      #Ouvrage.create! row.to_hash
     
      @ouvrage = Ouvrage.find_by_name(row[0])
      if !@ouvrage.nil?
       # @ouvrage.maitre_oeuvre = row[1]
        @ouvrage.budget = row[2]
        if !@ouvrage.budget.nil?
          @ouvrage.budget = @ouvrage.budget * 1000
        else 
          @ouvrage.budget = 0
        end
       # @ouvrage.adresse = row[3]
        @ouvrage.save
      end
    end
  end
  
    has_one_attached :photo, dependent: :destroy
end
