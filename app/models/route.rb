class Route < ActiveRecord::Base
  # Table follows geoespacial naming convention v stands for vector data
  self.table_name = 'v_routes'
end
