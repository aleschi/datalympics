class CreateSolideoFinancements < ActiveRecord::Migration[5.2]
  def change
    create_table :solideo_financements do |t|
      t.string :financeur
      t.float :financement_prevu
      t.float :financement_2018
      t.float :financement_2019
      t.float :financement_2020
      t.float :financement_2021
      t.float :financement_2022
      t.float :financement_2023
      t.float :financement_2024
      t.float :financement_2025

      t.timestamps
    end
  end
end
