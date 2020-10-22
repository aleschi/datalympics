class AddDateMaquetteToOuvragesDepense < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages_depenses, :date_maquette, :date
  end
end
