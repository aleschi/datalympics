class Choru < ApplicationRecord
  require 'csv'
  
  def self.import(file)
    CSV.foreach(file.path) do |row|
      if !row[0].nil? && !row[0].empty?
        if (row[7].nil? || row[7].empty?)  #si ce nest pas des actions
         
            if Choru.where('compte_budgetaire = ? AND operation = ? AND type_piece = ? AND centre_financier = ? AND type_ae = ?' , row[5],row[2],row[1],row[4],row[8]).count > 0 && Choru.where('compte_budgetaire = ? AND operation = ? AND type_piece = ? AND centre_financier = ? AND type_ae = ?' , row[5],row[2],row[1], row[4], row[8]).order('date DESC').first.date > row[0].to_date - 7.days #on rassemble
                  @chorus = Choru.where('compte_budgetaire = ? AND operation = ? AND type_piece = ? AND centre_financier = ? AND type_ae = ?' , row[5],row[2],row[1],row[4],row[8]).order('date DESC').first
                  @chorus.montant = @chorus.montant + row[6].to_f/100 #cumul

                  if @chorus.montant == 0 
                   @chorus.destroy
                  end         
            else #count == 0 ou pas dans dernier jours 
              @chorus = Choru.new
              @chorus.date = row[0]
              @chorus.type_piece = row[1]
              @chorus.operation = row[2]
              @chorus.type_budget = row[3]
              @chorus.centre_financier = row[4]
              @chorus.compte_budgetaire = row[5]
              @chorus.montant = row[6].to_f/100
              @chorus.type_ae = row[8]
              
            end 

            @chorus.save 
            if @chorus.date.nil?
              @chorus.destroy 
            end
        
        elsif (!row[7].nil? && !row[7].empty?) #c'est une action
          
          if Choru.where('compte_budgetaire = ? AND centre_financier = ?', row[5],row[4]).where.not(domaine_fonctionnel: nil).count > 0 && Choru.where('compte_budgetaire = ? AND centre_financier = ?' ,row[5],row[4]).where.not(domaine_fonctionnel: nil).order('date DESC').first.date > row[0].to_date - 7.days #on rassemble
                @chorus = Choru.where('compte_budgetaire = ? AND centre_financier = ?' ,row[5],row[4]).where.not(domaine_fonctionnel: nil).order('date DESC').first
                @chorus.montant = @chorus.montant + row[6].to_f/100 #cumul
                if @chorus.montant == 0 
                  @chorus.destroy
                end              
          else #=0 ou pas dans les 7 derniers jours 5167 
            @chorus = Choru.new
            @chorus.date = row[0]
            @chorus.type_piece = row[1]
            @chorus.operation = row[2]
            @chorus.type_budget = row[3]
            @chorus.centre_financier = row[4]
            @chorus.compte_budgetaire = row[5]
            @chorus.montant = row[6].to_f/100
            @chorus.domaine_fonctionnel = 'action'
            if !row[8].nil? && !row[8].empty?
              @chorus.type_ae = row[8]
            else
              @chorus.type_ae = "cp"
            end
          end

          @chorus.save 
          if @chorus.date.nil?
            @chorus.destroy 
          end
       
        end 
      end
    end
  end

  def self.import2(file)
    CSV.foreach(file.path) do |row|
      if !row[0].nil? && !row[0].empty?
      @chorus = Choru.new
      @chorus.date = row[0]
      @chorus.type_piece = row[1]
      @chorus.operation = row[2]
      @chorus.type_budget = row[3]
      @chorus.centre_financier = row[4]
      @chorus.compte_budgetaire = row[5]
      @chorus.montant = row[6].to_f/100
      @chorus.domaine_fonctionnel = row[7]
        if !row[8].nil? && !row[8].empty?
      @chorus.type_ae = row[8]
        end
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

   def self.import_nom(file)
      CSV.foreach(file.path) do |row|
          if !row[0].nil? && !row[0].empty?
            @chorus_nom = ChorusNomenclature.new
            @chorus_nom.nom = row[0]
            @chorus_nom.designation = row[1]
            @chorus_nom.save
            
          end
      end
  end
  
end
