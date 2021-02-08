class CreateMaquettes < ActiveRecord::Migration[5.2]
  def change
    create_table :maquettes do |t|
      t.string :name
      t.references :ouvrage, foreign_key: true
      t.integer :total
      t.integer :total_complementaire
      t.integer :total_public
      t.date :date
      t.string :commentaire

      t.timestamps
    end
  end
end
