class CreateOuvragesPublics < ActiveRecord::Migration[5.2]
  def change
    create_table :ouvrages_publics do |t|
      t.string :nom
      t.string :travaux
      t.string :appartenance
      t.references :ouvrages, foreign_key: true
      t.string :adresse

      t.timestamps
    end
  end
end
