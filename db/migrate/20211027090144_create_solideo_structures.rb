class CreateSolideoStructures < ActiveRecord::Migration[5.2]
  def change
    create_table :solideo_structures do |t|
      t.string :name
      t.string :categorie

      t.timestamps
    end
  end
end
