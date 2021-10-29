class DropChantier < ActiveRecord::Migration[5.2]
  def change
  	drop_table :chantiers
  end
end
