class AddFieldsToDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :appartenance, :string
    add_column :documents, :extension, :string
  end
end
