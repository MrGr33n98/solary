class AddFieldsToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :sponsor_badge, :string
    add_column :categories, :headline_h1, :string
    add_column :categories, :headline_h2, :string
    add_column :categories, :headline_h3, :string
    add_column :categories, :meta_title, :string
    add_column :categories, :meta_description, :text
    add_column :categories, :og_image, :string
    add_column :categories, :slug, :string
  end
end
