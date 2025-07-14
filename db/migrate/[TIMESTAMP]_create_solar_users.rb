class CreateSolarUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :solar_users do |t|
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :name
      t.integer :role, default: 0
      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end

    add_index :solar_users, :email, unique: true
    add_index :solar_users, :reset_password_token, unique: true
  end
end