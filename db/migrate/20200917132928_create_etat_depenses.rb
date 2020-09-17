class CreateEtatDepenses < ActiveRecord::Migration[5.2]
  def change
    create_table :etat_depenses do |t|
      t.datetime :date
      t.string :beneficiaire
      t.integer :titre
      t.integer :categorie
      t.float :ae_prevu
      t.float :ae_conso
      t.float :cp_prevu
      t.float :cp_conso

      t.timestamps
    end
  end
end
