class AddFieldsToSolideoFinancement < ActiveRecord::Migration[5.2]
  def change
    add_column :solideo_financements, :date, :date
    add_column :solideo_financements, :montant_prevu, :float
    add_column :solideo_financements, :montant, :float
    add_column :solideo_financements, :categorie, :string
  end
end
