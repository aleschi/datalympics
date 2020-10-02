class AddBudgetToOuvrage < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages, :budget, :float
  end
end
