class CreateTypeinnovations < ActiveRecord::Migration[5.2]
  def change
    create_table :typeinnovations do |t|
      t.references :innovation, foreign_key: true
      t.string :categorie

      t.timestamps
    end
  end
end
