class AddFieldsToSolideoDepense < ActiveRecord::Migration[5.2]
  def change
    add_column :solideo_depenses, :ouvrages, :float
    add_column :solideo_depenses, :fonctionnement, :float
    add_column :solideo_depenses, :reserve, :float
    add_column :solideo_depenses, :innovation, :float
  end
end
