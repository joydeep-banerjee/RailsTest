class AddIsPublicToLocationusers < ActiveRecord::Migration
  def change
        add_column :locationusers, :is_public, :integer
  end
end
