class CreateOuvragesDepenses < ActiveRecord::Migration[5.2]
  def change
    create_table :ouvrages_depenses do |t|
      t.date :date
      t.references :ouvrage, foreign_key: true
      t.string :name
      t.float :montant

      t.timestamps
    end
  end
end
