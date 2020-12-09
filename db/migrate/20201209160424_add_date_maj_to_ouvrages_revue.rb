class AddDateMajToOuvragesRevue < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages_revues, :date_maj, :date
  end
end
