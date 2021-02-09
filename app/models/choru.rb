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
      @chorus.montant = row[6].to_i/100
      @chorus.domaine_fonctionnel = row[7]
      @chorus.save 
        if @chorus.date.nil?
          @chorus.destroy 
        end
 
      end
    end
  end
  
  def self.import_conso(file)
    CSV.foreach(file.path) do |row|
      if !row[0].nil? && !row[0].empty?
        (1..12).each do |i|
          @chorus = Chorusconso.new
          @chorus.centre_financier = row[0]
          @chorus.action = row[1]
          @chorus.ae_conso = row[2*i].to_i
          @chorus.cp_conso = row[2*i+1].to_i
          @chorus.date = Date.new(2020,i,1)
        
        if @chorus.ae_conso.nil? 
          @chorus.ae_conso = 0
        end 
        if @chorus.cp_conso.nil?
          @chorus.cp_conso = 0
        end
      @chorus.save 
        if @chorus.date.nil?
          @chorus.destroy 
        end
          end
 
      end
    end
  end
  
end
