class SolideoFinanceurFinancement < ApplicationRecord
  belongs_to :solideo_financeur
  require 'roo'
  
  	def self.import(file)
     
  		data = Roo::Spreadsheet.open(file.path)
      	headers = data.row(1) # get header row
  		data.each_with_index do |row, idx|
        next if idx == 0 # skip header
        row_data = Hash[[headers, row].transpose]
        structure = SolideoFinanceur.where(name: row_data['FINANCEUR']).first
        	if !structure.nil?
	        	depense = structure.solideo_financeur_financements.create(date: row_data['date'].to_date, titres_emis: row_data['Titres émis'], encaissements: row_data['Encaissements'])
	  			
	  			if structure.solideo_financeur_budgets.count == 0 || structure.solideo_financeur_budgets.order(date: :asc).last.financement_global != row_data['Financement']  #si nexiste pas ou valeur d'un budget differente ce nouveau mois on met à jour 
	  				budget = structure.solideo_financeur_budgets.new
	  				budget.date = row_data['date'].to_date
	  				budget.financement_global = row_data['Financement']
	  				budget.save 
          		else #on met juste a jour la date 
		            budget = structure.solideo_financeur_budgets.last
		            budget.date = row_data['Financement'].to_date
		            budget.save 
	  			end
  			end
  		end
	end
end
