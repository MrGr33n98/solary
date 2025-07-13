class AddCreatedAndUpdatedByToSolarUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :solar_users, :created_by_id, :integer
    add_column :solar_users, :updated_by_id, :integer
  end
end