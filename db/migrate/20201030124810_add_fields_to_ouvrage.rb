class AddFieldsToOuvrage < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages, :latitude, :float
    add_column :ouvrages, :longitude, :float
  end
end
