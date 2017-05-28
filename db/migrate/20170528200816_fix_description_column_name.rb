class FixDescriptionColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :v_routes, :descriptio, :description
  end
end
