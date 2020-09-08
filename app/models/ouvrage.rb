class Ouvrage < ApplicationRecord
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path) do |row|
      #Ouvrage.create! row.to_hash
      @ouvrage = Ouvrage.new
      @ouvrage.name = row[0]
      @ouvrage.save
    end

  end
end
