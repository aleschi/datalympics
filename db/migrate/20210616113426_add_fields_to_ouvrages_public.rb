class AddFieldsToOuvragesPublic < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages_publics, :latitude, :float
    add_column :ouvrages_publics, :longitude, :float
  end
end
