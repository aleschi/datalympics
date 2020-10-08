class ChangeDateToBeDateInEtatDepense < ActiveRecord::Migration[5.2]
  def change
    change_column :etat_depenses, :date, :date
  end
end
