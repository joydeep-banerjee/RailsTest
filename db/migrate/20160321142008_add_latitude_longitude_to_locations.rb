class AddLatitudeLongitudeToLocations < ActiveRecord::Migration
  def change
        add_column :locations, :latitude, :string
        add_column :locations, :langitude, :string
  end
end
