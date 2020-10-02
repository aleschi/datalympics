class AddMontantPrevuToOuvragesFinancement < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages_financements, :montant_prevu, :float
  end
end
