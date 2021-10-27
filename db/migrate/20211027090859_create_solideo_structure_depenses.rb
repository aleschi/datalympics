class CreateSolideoStructureDepenses < ActiveRecord::Migration[5.2]
  def change
    create_table :solideo_structure_depenses do |t|
      t.date :date
      t.float :droits_constates_cumul
      t.float :droits_constates_annee
      t.float :montants_engages_cumul
      t.references :solideo_structure, foreign_key: true

      t.timestamps
    end
  end
end
