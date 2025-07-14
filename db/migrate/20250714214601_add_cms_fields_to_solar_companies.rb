class AddCmsFieldsToSolarCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :solar_companies, :title_h1, :string
    add_column :solar_companies, :title_h2, :string
    add_column :solar_companies, :show_breadcrumbs, :boolean, default: false, null: false
    add_column :solar_companies, :show_header, :boolean, default: false, null: false
    add_column :solar_companies, :show_search_reviews, :boolean, default: false, null: false
    add_column :solar_companies, :show_filter_by_rating, :boolean, default: false, null: false
    add_column :solar_companies, :show_sort_dropdown, :boolean, default: false, null: false
    add_column :solar_companies, :show_overall_rating, :boolean, default: false, null: false
    add_column :solar_companies, :show_rating_breakdown, :boolean, default: false, null: false
    add_column :solar_companies, :show_reviews_list, :boolean, default: false, null: false
    add_column :solar_companies, :show_pagination, :boolean, default: false, null: false
    add_column :solar_companies, :show_sidebar_top_companies, :boolean, default: false, null: false
  end
end
