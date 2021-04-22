class AddFieldsToChantier < ActiveRecord::Migration[5.2]
  def change
    add_column :chantiers, :code, :string
    add_column :chantiers, :site, :string
    add_column :chantiers, :libelle, :string
    add_column :chantiers, :typecontrat, :string
    add_column :chantiers, :datesignature, :date
    add_column :chantiers, :total_depenses_actees, :float
    add_column :chantiers, :depenses_actees_annee, :float
    add_column :chantiers, :jalons_annee, :float
    add_column :chantiers, :paiements_annee, :float
    add_column :chantiers, :paiements_attente_annee, :float
    add_column :chantiers, :budget_annee, :float
    add_column :chantiers, :cumul_depenses_actees, :float
    add_column :chantiers, :cumul_jalons, :float
    add_column :chantiers, :cumul_paiements, :float
  end
end
