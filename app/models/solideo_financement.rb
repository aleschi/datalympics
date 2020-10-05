class SolideoFinancement < ApplicationRecord
  require 'csv'
  
  def self.import(file)
    CSV.foreach(file.path) do |row|
      #Ouvrage.create! row.to_hash
      @financement = SolideoFinancement.new
      @financement.financeur = row[0]
      
      @financement.save
    end

  end
end
