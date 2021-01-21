class CreateChorus < ActiveRecord::Migration[5.2]
  def change
    create_table :chorus do |t|
      t.date :date
      t.string :type_piece
      t.string :type_budget
      t.string :operation
      t.string :centre_financier
      t.string :compte_budgetaire
      t.integer :montant

      t.timestamps
    end
  end
end
