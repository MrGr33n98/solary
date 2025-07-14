class AddSeoFieldsToSubcategories < ActiveRecord::Migration[7.0]
  def change
    add_column :subcategories, :sponsor_badge, :string
    add_column :subcategories, :headline_h1, :string
    add_column :subcategories, :headline_h2, :string
    add_column :subcategories, :headline_h3, :string
    add_column :subcategories, :meta_title, :string
    add_column :subcategories, :meta_description, :text
    add_column :subcategories, :og_image, :string
  end
end
