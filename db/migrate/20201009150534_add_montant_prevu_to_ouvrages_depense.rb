class AddMontantPrevuToOuvragesDepense < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages_depenses, :montant_prevu, :float
  end
end
