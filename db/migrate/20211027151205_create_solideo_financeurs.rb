class CreateSolideoFinanceurs < ActiveRecord::Migration[5.2]
  def change
    create_table :solideo_financeurs do |t|
      t.string :name
      t.string :categorie

      t.timestamps
    end
  end
end
