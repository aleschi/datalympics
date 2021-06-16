class AddFieldsToDiscipline < ActiveRecord::Migration[5.2]
  def change
    add_column :disciplines, :epreuves, :string
    add_reference :disciplines, :ouvrages_publics, foreign_key: true
  end
end
