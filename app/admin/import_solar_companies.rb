ActiveAdmin.register_page "Import Solar Companies" do
  menu parent: "Solar Companies", label: "Import CSV"

  controller do
    skip_authorization_check
  end

  content title: proc{ I18n.t("active_admin.import_solar_companies") } do
    panel "Importar Empresas via CSV" do
      active_admin_form_for :upload,
                            url: "/admin/import_solar_companies/upload_csv", # Usando a string do caminho diretamente
                            method: :post,
                            html: { enctype: "multipart/form-data" } do |f|
        f.inputs "Selecione o arquivo CSV" do
          f.input :csv_file, as: :file, label: "Arquivo CSV", input_html: { name: "upload[csv_file]" }
        end
        f.actions do
          f.action :submit, label: "Importar"
        end
      end
    end
  end

  page_action :upload_csv, method: :post do
    csv_file_param = params[:upload] && params[:upload][:csv_file] || params[:csv_file]
    if csv_file_param.present?
      require 'csv'
      csv_file = csv_file_param.path
      begin
        CSV.foreach(csv_file, headers: true) do |row|
          SolarCompany.create!(
            name: row['name'],
            location: row['location'],
            installed_capacity_mw: row['installed_capacity_mw'].to_f,
            user_id: SolarUser.find_by(email: row['user_email'])&.id || SolarUser.first.id, # Adjust logic
            status: row['status']
          )
        end
        redirect_to admin_import_solar_companies_path, notice: 'CSV uploaded and companies imported successfully!'
      rescue StandardError => e
        redirect_to admin_import_solar_companies_path, alert: "Error importing CSV: #{e.message}"
      end
    else
      redirect_to admin_import_solar_companies_path, alert: 'Please select a CSV file.'
    end
  end
end