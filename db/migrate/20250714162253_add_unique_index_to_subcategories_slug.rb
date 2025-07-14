class AddUniqueIndexToSubcategoriesSlug < ActiveRecord::Migration[7.0]
  def change
    add_index :subcategories, :slug, unique: true
  end
end
