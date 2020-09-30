class AddCategorieToSolideoDepense < ActiveRecord::Migration[5.2]
  def change
    add_column :solideo_depenses, :categorie, :string
  end
end
