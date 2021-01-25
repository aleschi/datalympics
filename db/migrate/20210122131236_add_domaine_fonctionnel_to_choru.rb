class AddDomaineFonctionnelToChoru < ActiveRecord::Migration[5.2]
  def change
    add_column :chorus, :domaine_fonctionnel, :string
  end
end
