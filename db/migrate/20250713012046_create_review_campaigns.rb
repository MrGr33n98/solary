class CreateReviewCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :review_campaigns do |t|
      t.references :solar_company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: { to_table: :solar_users }
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end