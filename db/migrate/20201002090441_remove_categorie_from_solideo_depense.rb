class RemoveCategorieFromSolideoDepense < ActiveRecord::Migration[5.2]
  def change
    remove_column :solideo_depenses, :categorie, :string
  end
end
