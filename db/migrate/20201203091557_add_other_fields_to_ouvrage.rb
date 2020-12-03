class AddOtherFieldsToOuvrage < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages, :description, :string
    add_column :ouvrages, :phase_jo, :string
    add_column :ouvrages, :heritage, :string
    add_column :ouvrages, :date, :date
    add_column :ouvrages, :start, :date
    add_column :ouvrages, :end, :date
  end
end
