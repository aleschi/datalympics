class CreateSolideoStructureBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :solideo_structure_budgets do |t|
      t.date :date
      t.float :budget_global
      t.float :budget_annee
      t.references :solideo_structure, foreign_key: true

      t.timestamps
    end
  end
end
