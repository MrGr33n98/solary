class CreateSaasSponsoreds < ActiveRecord::Migration[7.0]
  def change
    create_table :saas_sponsoreds do |t|
      t.references :solar_company, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :budget, precision: 10, scale: 2
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end