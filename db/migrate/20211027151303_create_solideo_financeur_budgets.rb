class CreateSolideoFinanceurBudgets < ActiveRecord::Migration[5.2]
  def change
    create_table :solideo_financeur_budgets do |t|
      t.date :date
      t.float :financement_global
      t.references :solideo_financeur, foreign_key: true

      t.timestamps
    end
  end
end
