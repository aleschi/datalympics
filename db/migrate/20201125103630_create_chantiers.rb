class CreateChantiers < ActiveRecord::Migration[5.2]
  def change
    create_table :chantiers do |t|
      t.string :name
      t.references :ouvrage, foreign_key: true

      t.timestamps
    end
  end
end
