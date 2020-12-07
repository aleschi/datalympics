class CreateOuvragesRevues < ActiveRecord::Migration[5.2]
  def change
    create_table :ouvrages_revues do |t|
      t.date :date
      t.references :ouvrage, foreign_key: true
      t.string :delai_commentaire
      t.string :delai_action
      t.float :delai_time
      t.integer :budget_indicateur
      t.string :budget_commentaire
      t.string :budget_action

      t.timestamps
    end
  end
end
