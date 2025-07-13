class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.string :duration
      t.text :features

      t.timestamps
    end
  end
end