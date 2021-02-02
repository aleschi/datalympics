class Choru < ApplicationRecord
  require 'csv'
  
  def self.import(file)
    CSV.foreach(file.path) do |row|
      if !row[0].nil? && !row[0].empty?
      @chorus = Choru.new
      @chorus.date = row[0]
      @chorus.type_piece = row[1]
      @chorus.operation = row[2]
      @chorus.type_budget = row[3]
      @chorus.centre_financier = row[4]
      @chorus.compte_budgetaire = row[5]
      @chorus.montant = row[6]
      @chorus.domaine_fonctionnel = row[7]
      @chorus.save 
        if @chorus.date.nil?
          @chorus.destroy 
        end
 
      end
    end
  end
  
end
