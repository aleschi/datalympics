class SolideoStructure < ApplicationRecord
	has_many :solideo_structure_budgets
	has_many :solideo_structure_depenses
	require 'roo'
  
  	def self.import(file)
     
  		data = Roo::Spreadsheet.open(file.path)
      	headers = data.row(1) # get header row
  		data.each_with_index do |row, idx|
        next if idx == 0 # skip header
        row_data = Hash[[headers, row].transpose]
        SolideoStructure.where(name: row_data['NOM'], categorie: row_data['CATEGORIE']).first_or_create do |s|
        	s.name = row_data['NOM']
        	s.categorie = row_data['CATEGORIE']
        end
  		end
	end
end
