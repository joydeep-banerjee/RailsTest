class RemoveLocationIdFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :location_id, :integer
  end
end
