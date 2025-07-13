class CreateSaasMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :saas_members do |t|
      t.references :user, null: false, foreign_key: { to_table: :solar_users }
      t.references :plan, null: false, foreign_key: true
      t.string :subscription_status, null: false, default: 'pending'
      t.decimal :billing_amount, precision: 10, scale: 2
      t.datetime :billing_date
      t.timestamps
    end
  end
end
