class CreateConventions < ActiveRecord::Migration[5.2]
  def change
    create_table :conventions do |t|
      t.integer :travaux_signature
      t.integer :objectifs_signature
      t.integer :etudes_signature
      t.integer :objectifs_encours
      t.integer :avenants_objectifs_encours
      t.integer :avenants_travaux_encours
      t.integer :protocole_etudes_encours
      t.integer :objectifs_elaboration
      t.date :date

      t.timestamps
    end
  end
end
