class RemoveDetailsFromSolideoDepense < ActiveRecord::Migration[5.2]
  def change
    remove_column :solideo_depenses, :details, :string
  end
end
