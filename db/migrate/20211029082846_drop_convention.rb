class DropConvention < ActiveRecord::Migration[5.2]
  def change
  	drop_table :conventions
  end
end
