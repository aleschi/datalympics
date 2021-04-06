class CreateChorusNomenclatures < ActiveRecord::Migration[5.2]
  def change
    create_table :chorus_nomenclatures do |t|
      t.string :nom
      t.string :designation

      t.timestamps
    end
  end
end
