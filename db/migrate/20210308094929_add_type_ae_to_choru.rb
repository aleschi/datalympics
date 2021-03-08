class AddTypeAeToChoru < ActiveRecord::Migration[5.2]
  def change
    add_column :chorus, :type_ae, :string, default: "cp"
  end
end
