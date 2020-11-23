class AddDateToDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :date, :date
  end
end
