class InterestPoint < ActiveRecord::Base
  # Table follows geoespacial naming convention v stands for vector data
  self.table_name = 'v_interest_points'
  after_commit -> { Rails.cache.clear }
end
