class CreateChorusconsos < ActiveRecord::Migration[5.2]
  def change
    create_table :chorusconsos do |t|
      t.string :centre_financier
      t.string :action
      t.date :date
      t.integer :ae_conso
      t.integer :cp_conso

      t.timestamps
    end
  end
end
