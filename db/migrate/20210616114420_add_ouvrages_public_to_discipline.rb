class AddOuvragesPublicToDiscipline < ActiveRecord::Migration[5.2]
  def change
    add_reference :disciplines, :ouvrages_public, foreign_key: true
  end
end
