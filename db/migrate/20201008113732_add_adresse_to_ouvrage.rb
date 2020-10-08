class AddAdresseToOuvrage < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages, :adresse, :string
  end
end
