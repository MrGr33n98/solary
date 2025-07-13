class CreateSolarContents < ActiveRecord::Migration[7.0]
  def change
    create_table :solar_contents do |t|
      t.references :solar_company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: { to_table: :solar_users }
      t.string :title
      t.string :content_type
      t.text :body
      t.references :category, null: true, foreign_key: true
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end