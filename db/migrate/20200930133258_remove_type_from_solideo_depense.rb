class RemoveTypeFromSolideoDepense < ActiveRecord::Migration[5.2]
  def change
    remove_column :solideo_depenses, :type, :string
  end
end
