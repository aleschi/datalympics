class CreateInnovations < ActiveRecord::Migration[5.2]
  def change
    create_table :innovations do |t|
      t.string :nom
      t.string :porteur
      t.references :ouvrage, foreign_key: true
      t.float :dotation
      t.date :date
      t.string :description

      t.timestamps
    end
  end
end
