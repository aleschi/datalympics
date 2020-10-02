class CreateOuvragesFinanceurs < ActiveRecord::Migration[5.2]
  def change
    create_table :ouvrages_financeurs do |t|
      t.references :ouvrage, foreign_key: true
      t.string :name
      t.float :financement_prevu
      t.float :financement_actuel

      t.timestamps
    end
  end
end
