class CreateEtatBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :etat_budgets do |t|
      t.datetime :date
      t.float :budget_total
      t.float :budget_solideo
      t.float :budget_cojo
      t.float :budget_heritage
      t.float :budget_hauteperformance

      t.timestamps
    end
  end
end
