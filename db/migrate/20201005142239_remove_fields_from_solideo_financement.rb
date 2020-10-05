class RemoveFieldsFromSolideoFinancement < ActiveRecord::Migration[5.2]
  def change
    remove_column :solideo_financements, :financement_prevu, :float
    remove_column :solideo_financements, :financement_2018, :float
    remove_column :solideo_financements, :financement_2019, :float
    remove_column :solideo_financements, :financement_2020, :float
    remove_column :solideo_financements, :financement_2021, :float
    remove_column :solideo_financements, :financement_2022, :float
    remove_column :solideo_financements, :financement_2023, :float
    remove_column :solideo_financements, :financement_2024, :float
    remove_column :solideo_financements, :financement_2025, :float
  end
end
