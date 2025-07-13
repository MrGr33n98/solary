class CreateSaasAccessManagements < ActiveRecord::Migration[7.0]
  def change
    create_table :saas_access_managements do |t|
      t.references :user, null: false, foreign_key: { to_table: :solar_users }
      t.string :access_level, null: false, default: "read"
      t.string :status, null: false, default: "pending"
      t.text :notes
      t.timestamps
    end
  end
end