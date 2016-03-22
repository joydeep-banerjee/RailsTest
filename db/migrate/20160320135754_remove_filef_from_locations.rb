class RemoveFilefFromLocations < ActiveRecord::Migration
  def change
        add_column :locations, :location, :string
        remove_column :locations, :shared_by_id, :integer
        remove_column :locations, :shared_to_id, :integer
  end
end
