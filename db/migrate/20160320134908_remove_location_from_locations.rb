class RemoveLocationFromLocations < ActiveRecord::Migration
  def change
       remove_column :locations, :location, :string
  end
end
