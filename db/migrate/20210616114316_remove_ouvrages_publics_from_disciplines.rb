class RemoveOuvragesPublicsFromDisciplines < ActiveRecord::Migration[5.2]
  def change
    remove_reference :disciplines, :ouvrages_publics, foreign_key: true
  end
end
