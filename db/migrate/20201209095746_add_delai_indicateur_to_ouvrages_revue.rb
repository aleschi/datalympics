class AddDelaiIndicateurToOuvragesRevue < ActiveRecord::Migration[5.2]
  def change
    add_column :ouvrages_revues, :delai_indicateur, :integer, default: 1
  end
end
