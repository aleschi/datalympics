class SolideoStructureDepense < ApplicationRecord
  belongs_to :solideo_structure

  require 'roo'
  
  	def self.import(file)
     
  		data = Roo::Spreadsheet.open(file.path)
      	headers = data.row(1) # get header row
  		data.each_with_index do |row, idx|
        next if idx == 0 # skip header
        row_data = Hash[[headers, row].transpose]
        structure = SolideoStructure.where(name: row_data['Structure']).first
        	if !structure.nil?
	        	depense = structure.solideo_structure_depenses.create(date: row_data['date'].to_date, droits_constates_cumul: row_data['Droits constatés'], droits_constates_annee: row_data['Droits constatés année'], montants_engages_cumul: row_data['Engagé'])
	  			
	  			if structure.solideo_structure_budgets.count == 0 || structure.solideo_structure_budgets.order(date: :asc).last.budget_global != row_data['Budget Global'] || structure.solideo_structure_budgets.order(date: :asc).last.budget_annee != row_data['Budget Année'] #si nexiste pas ou valeur d'un budget differente ce nouveau mois on met à jour 
	  				budget = structure.solideo_structure_budgets.new
	  				budget.date = row_data['date'].to_date
	  				budget.budget_global = row_data['Budget Global']
	  				budget.budget_annee = row_data['Budget Année']
	  				budget.save 
          else #on met juste a jour la date 
            budget = structure.solideo_structure_budgets.last
            budget.date = row_data['date'].to_date
            budget.save 
	  			end
  			end
  		end
	end
end
