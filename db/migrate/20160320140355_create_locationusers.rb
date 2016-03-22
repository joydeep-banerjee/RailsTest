class CreateLocationusers < ActiveRecord::Migration
  def change
    create_table :locationusers do |t|
        t.integer :location_id
        t.integer :shared_by_id
        t.integer :shared_to_id 
    end
  end
end
