class CreateSolarCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :solar_companies do |t|
      t.string :name
      t.string :location
      t.decimal :installed_capacity_mw, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: { to_table: :solar_users }
      t.string :status
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end