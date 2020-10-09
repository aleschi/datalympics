class AddMontantEngageToOuvragesDepense < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages_depenses, :montant_engage, :float
  end
end
