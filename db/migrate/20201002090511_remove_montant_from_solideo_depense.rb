class RemoveMontantFromSolideoDepense < ActiveRecord::Migration[5.2]
  def change
    remove_column :solideo_depenses, :montant, :float
  end
end
