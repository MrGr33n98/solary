ActiveAdmin.register SolarCompany do
  controller do
    skip_authorization_check only: [:index, :new, :show, :edit, :upload_csv, :import_csv]

    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  permit_params :name, :slug, :cnpj, :street_address, :city, :state, :postal_code, :latitude, :longitude,
                :contact_name, :contact_email, :contact_phone, :website, :facebook_url, :twitter_url, :linkedin_url,
                :installed_capacity_mwp, :commissioning_date, :module_technology, :module_brand, :module_count,
                :inverter_brand, :inverter_model, :avg_rating, :reviews_count, :total_energy_generated_mwh,
                :meta_title, :meta_description, :meta_keywords, :status, :created_by_id, :updated_by_id, :deleted_at,
                photos: [], logo: [], cover_image: [], csv_file: []

  index do
    selectable_column
    id_column
    column :name
    column :slug
    column :cnpj
    column :city
    column :state
    column :status
    column :installed_capacity_mwp
    column :avg_rating
    column :reviews_count
    column :creator
    column :updater
    column :created_at
    actions
  end

  filter :name
  filter :slug
  filter :cnpj
  filter :city
  filter :state
  filter :status, as: :select, collection: SolarCompany.statuses.keys
  filter :installed_capacity_mwp
  filter :avg_rating
  filter :reviews_count
  filter :created_by_id, as: :select, collection: -> { SolarUser.all.map { |u| [u.email, u.id] } }
  filter :updated_by_id, as: :select, collection: -> { SolarUser.all.map { |u| [u.email, u.id] } }
  filter :created_at

  action_item :import_csv, only: :index do
    link_to 'Importar Empresas CSV', admin_import_solar_companies_path
  end

  form do |f|
    f.inputs "Identificação" do
      f.input :name
      f.input :slug
      f.input :cnpj
    end

    f.inputs "Endereço & Geolocalização" do
      f.input :street_address
      f.input :city
      f.input :state
      f.input :postal_code
      f.input :latitude
      f.input :longitude
    end

    f.inputs "Contato & Web" do
      f.input :contact_name
      f.input :contact_email
      f.input :contact_phone
      f.input :website
      f.input :facebook_url
      f.input :twitter_url
      f.input :linkedin_url
    end

    f.inputs "Branding & Imagens" do
      f.input :logo, as: :file
      f.input :cover_image, as: :file
      f.input :photos, as: :file, input_html: { multiple: true }
    end

    f.inputs "Especificações Técnicas" do
      f.input :installed_capacity_mwp
      f.input :commissioning_date, as: :datepicker
      f.input :module_technology
      f.input :module_brand
      f.input :module_count
      f.input :inverter_brand
      f.input :inverter_model
    end

    f.inputs "Indicadores & Métricas" do
      f.input :avg_rating
      f.input :reviews_count
      f.input :total_energy_generated_mwh
    end

    f.inputs "SEO & Metadados" do
      f.input :meta_title
      f.input :meta_description
      f.input :meta_keywords
    end

    f.inputs "Governança & Auditoria" do
      f.input :status, as: :select, collection: SolarCompany.statuses.keys
      f.input :created_by_id, as: :select, collection: SolarUser.all.map { |u| [u.email, u.id] }
      f.input :updated_by_id, as: :select, collection: SolarUser.all.map { |u| [u.email, u.id] }
      f.input :deleted_at, as: :datetime_picker
    end

    f.actions
  end
end