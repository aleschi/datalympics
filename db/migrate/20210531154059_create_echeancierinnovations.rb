class CreateEcheancierinnovations < ActiveRecord::Migration[5.2]
  def change
    create_table :echeancierinnovations do |t|
      t.references :innovation, foreign_key: true
      t.date :date
      t.float :montant
      t.boolean :versement

      t.timestamps
    end
  end
end
