class AddDateToChantier < ActiveRecord::Migration[5.2]
  def change
    add_column :chantiers, :date, :date
  end
end
