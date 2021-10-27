class CreateSolideoFinanceurFinancements < ActiveRecord::Migration[5.2]
  def change
    create_table :solideo_financeur_financements do |t|
      t.date :date
      t.float :titres_emis
      t.float :encaissements
      t.references :solideo_financeur, foreign_key: true

      t.timestamps
    end
  end
end
