class DropOuvragesRevue < ActiveRecord::Migration[5.2]
  def change
  	drop_table :ouvrages_revues
  end
end
