class RemoveOuvragesFromOuvragesPublic < ActiveRecord::Migration[5.2]
  def change
    remove_reference :ouvrages_publics, :ouvrages, foreign_key: true
  end
end
