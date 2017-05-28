class FixTypeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :v_interest_points, :type, :category
  end
end
