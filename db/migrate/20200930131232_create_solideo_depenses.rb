class CreateSolideoDepenses < ActiveRecord::Migration[5.2]
  def change
    create_table :solideo_depenses do |t|
      t.date :date
      t.float :montant
      t.string :type
      t.string :details

      t.timestamps
    end
  end
end
