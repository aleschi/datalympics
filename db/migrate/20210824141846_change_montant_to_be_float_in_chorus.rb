class ChangeMontantToBeFloatInChorus < ActiveRecord::Migration[5.2]
  def change
  	change_column :chorus, :montant, :float
  end
end
