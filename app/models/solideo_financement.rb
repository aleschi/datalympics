class SolideoFinancement < ApplicationRecord
  require 'csv'
  
  def self.import(file)
    CSV.foreach(file.path) do |row|
      #Ouvrage.create! row.to_hash
      @financement = SolideoFinancement.new
      @financement.financeur = row[0]
      @financement.financement_prevu = row[1]
      @financement.financement_2018 = row[2]
      @financement.financement_2019 = row[3]
      @financement.financement_2020 = row[4]
      @financement.financement_2021 = row[5]
      @financement.financement_2022 = row[6]
      @financement.financement_2023 = row[7]
      @financement.financement_2024 = row[8]
      @financement.financement_2025 = row[9]
      @financement.save
    end

  end
end
