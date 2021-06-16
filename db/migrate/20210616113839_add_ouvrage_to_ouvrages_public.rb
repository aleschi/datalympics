class AddOuvrageToOuvragesPublic < ActiveRecord::Migration[5.2]
  def change
    add_reference :ouvrages_publics, :ouvrage, foreign_key: true
  end
end
