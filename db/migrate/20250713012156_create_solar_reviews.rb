class CreateSolarReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :solar_reviews do |t|
      t.references :solar_company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: { to_table: :solar_users }
      t.integer :rating
      t.text :comment
      t.string :status
      t.references :review_campaign, null: true, foreign_key: true
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end