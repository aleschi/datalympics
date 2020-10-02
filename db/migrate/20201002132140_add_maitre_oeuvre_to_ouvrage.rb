class AddMaitreOeuvreToOuvrage < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages, :maitre_oeuvre, :string
  end
end
