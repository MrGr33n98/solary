class RefactorSolarCompanies < ActiveRecord::Migration[7.0]
  # Define SolarCompany class outside the up/down methods
  class SolarCompany < ActiveRecord::Base
    self.table_name = 'solar_companies'
  end

  def up
    # Add new columns as nullable first
    add_column :solar_companies, :slug, :string
    add_column :solar_companies, :cnpj, :string
    add_column :solar_companies, :street_address, :string
    add_column :solar_companies, :city, :string
    add_column :solar_companies, :state, :string
    add_column :solar_companies, :postal_code, :string
    add_column :solar_companies, :latitude, :decimal, precision: 10, scale: 6
    add_column :solar_companies, :longitude, :decimal, precision: 10, scale: 6
    add_column :solar_companies, :contact_name, :string
    add_column :solar_companies, :contact_email, :string
    add_column :solar_companies, :contact_phone, :string
    add_column :solar_companies, :website, :string
    add_column :solar_companies, :facebook_url, :string
    add_column :solar_companies, :twitter_url, :string
    add_column :solar_companies, :linkedin_url, :string
    add_column :solar_companies, :commissioning_date, :date
    add_column :solar_companies, :module_technology, :string
    add_column :solar_companies, :module_brand, :string
    add_column :solar_companies, :module_count, :integer
    add_column :solar_companies, :inverter_brand, :string
    add_column :solar_companies, :inverter_model, :string
    add_column :solar_companies, :avg_rating, :float, default: 0.0
    add_column :solar_companies, :reviews_count, :integer, default: 0
    add_column :solar_companies, :total_energy_generated_mwh, :decimal, precision: 12, scale: 2, default: 0.0
    add_column :solar_companies, :meta_title, :string
    add_column :solar_companies, :meta_description, :string
    add_column :solar_companies, :meta_keywords, :string
    add_column :solar_companies, :deleted_at, :datetime

    # Rename existing column
    rename_column :solar_companies, :installed_capacity_mw, :installed_capacity_mwp

    # Change existing column types and constraints
    change_column :solar_companies, :installed_capacity_mwp, :decimal, precision: 10, scale: 2, null: false
    change_column :solar_companies, :status, :string, null: false, default: "pending"

    # Populate new columns for existing records
    SolarCompany.reset_column_information
    SolarCompany.find_each do |company|
      company.slug = company.name.parameterize if company.name.present?
      company.cnpj = "00.000.000/0000-00" # Placeholder, replace with actual logic if available
      company.street_address = "Rua Exemplo, 123"
      company.city = "Cidade Exemplo"
      company.state = "Estado Exemplo"
      company.contact_name = "Contato Exemplo"
      company.contact_email = "contato@exemplo.com"
      company.save! # Use save! to trigger validations and callbacks
    end

    # Make new columns non-nullable
    change_column_null :solar_companies, :slug, false
    change_column_null :solar_companies, :cnpj, false
    change_column_null :solar_companies, :street_address, false
    change_column_null :solar_companies, :city, false
    change_column_null :solar_companies, :state, false
    change_column_null :solar_companies, :contact_name, false
    change_column_null :solar_companies, :contact_email, false

    # Add indexes
    add_index :solar_companies, :slug, unique: true unless index_exists?(:solar_companies, :slug)
    add_index :solar_companies, :cnpj, unique: true unless index_exists?(:solar_companies, :cnpj)
    add_index :solar_companies, :created_by_id unless index_exists?(:solar_companies, :created_by_id)
    add_index :solar_companies, :updated_by_id unless index_exists?(:solar_companies, :updated_by_id)
    add_index :solar_companies, :deleted_at unless index_exists?(:solar_companies, :deleted_at)

    # Add foreign keys for created_by_id and updated_by_id (assuming they already exist)
    add_foreign_key :solar_companies, :solar_users, column: :created_by_id unless foreign_key_exists?(:solar_companies, :solar_users, column: :created_by_id)
    add_foreign_key :solar_companies, :solar_users, column: :updated_by_id unless foreign_key_exists?(:solar_companies, :solar_users, column: :updated_by_id)

    # Remove old user_id column and its foreign key
    if foreign_key_exists?(:solar_companies, :users)
      remove_foreign_key :solar_companies, :users
    elsif foreign_key_exists?(:solar_companies, :solar_users, column: :user_id)
      remove_foreign_key :solar_companies, :solar_users, column: :user_id
    end

    if column_exists?(:solar_companies, :user_id)
      remove_column :solar_companies, :user_id
    end
  end

  def down
    # Revert null constraints first
    change_column_null :solar_companies, :slug, true
    change_column_null :solar_companies, :cnpj, true
    change_column_null :solar_companies, :street_address, true
    change_column_null :solar_companies, :city, true
    change_column_null :solar_companies, :state, true
    change_column_null :solar_companies, :contact_name, true
    change_column_null :solar_companies, :contact_email, true

    # Remove foreign keys
    remove_foreign_key :solar_companies, :solar_users, column: :created_by_id if foreign_key_exists?(:solar_companies, :solar_users, column: :created_by_id)
    remove_foreign_key :solar_companies, :solar_users, column: :updated_by_id if foreign_key_exists?(:solar_companies, :solar_users, column: :updated_by_id)

    # Remove indexes
    remove_index :solar_companies, :slug if index_exists?(:solar_companies, :slug)
    remove_index :solar_companies, :cnpj if index_exists?(:solar_companies, :cnpj)
    remove_index :solar_companies, :created_by_id if index_exists?(:solar_companies, :created_by_id)
    remove_index :solar_companies, :updated_by_id if index_exists?(:solar_companies, :updated_by_id)
    remove_index :solar_companies, :deleted_at if index_exists?(:solar_companies, :deleted_at)

    # Revert column changes
    rename_column :solar_companies, :installed_capacity_mwp, :installed_capacity_mw
    change_column :solar_companies, :installed_capacity_mw, :decimal, precision: 10, scale: 2, null: true # Revert to original nullability if it was nullable
    change_column :solar_companies, :status, :string, null: true, default: nil # Revert to original nullability and default

    # Remove added columns
    remove_column :solar_companies, :slug
    remove_column :solar_companies, :cnpj
    remove_column :solar_companies, :street_address
    remove_column :solar_companies, :city
    remove_column :solar_companies, :state
    remove_column :solar_companies, :postal_code
    remove_column :solar_companies, :latitude
    remove_column :solar_companies, :longitude
    remove_column :solar_companies, :contact_name
    remove_column :solar_companies, :contact_email
    remove_column :solar_companies, :contact_phone
    remove_column :solar_companies, :website
    remove_column :solar_companies, :facebook_url
    remove_column :solar_companies, :twitter_url
    remove_column :solar_companies, :linkedin_url
    remove_column :solar_companies, :commissioning_date
    remove_column :solar_companies, :module_technology
    remove_column :solar_companies, :module_brand
    remove_column :solar_companies, :module_count
    remove_column :solar_companies, :inverter_brand
    remove_column :solar_companies, :inverter_model
    remove_column :solar_companies, :avg_rating
    remove_column :solar_companies, :reviews_count
    remove_column :solar_companies, :total_energy_generated_mwh
    remove_column :solar_companies, :meta_title
    remove_column :solar_companies, :meta_description
    remove_column :solar_companies, :meta_keywords
    remove_column :solar_companies, :deleted_at

    # Re-add user_id column and its foreign key if it was removed
    add_column :solar_companies, :user_id, :integer
    add_foreign_key :solar_companies, :solar_users, column: :user_id # Assuming it was solar_users
  end

  # Helper methods to check existence before attempting removal
  def foreign_key_exists?(from_table, to_table, options = {})
    foreign_keys(from_table).any? do |fk|
      fk.to_table.to_s == to_table.to_s &&
      (options[:column].nil? || fk.column.to_s == options[:column].to_s)
    end
  end

  def column_exists?(table_name, column_name)
    ActiveRecord::Base.connection.column_exists?(table_name, column_name)
  end

  def index_exists?(table_name, column_name)
    ActiveRecord::Base.connection.index_exists?(table_name, column_name)
  end
end