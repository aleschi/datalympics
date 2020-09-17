class DropBudgetEtats < ActiveRecord::Migration[5.2]
  def change
    drop_table :budget_etats
  end
end
