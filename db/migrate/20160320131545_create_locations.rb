class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
        t.string :location
        t.integer :shared_by_id
        t.integer :shared_to_id      
    end
  end
end
