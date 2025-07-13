ActiveAdmin.register SaasAccessManagement do
  menu priority: 2, label: "Saas Access Management"
  permit_params :user_id, :access_level, :status, :notes

  index do
    selectable_column
    id_column
    column :user
    column :access_level
    column :status
    column :notes
    actions
  end

  filter :user_id, as: :select, collection: SolarUser.all.map { |u| [u.email, u.id] }
  filter :access_level
  filter :status
  filter :notes

  form do |f|
    f.inputs "Saas Access Management" do
      f.input :user_id, as: :select, collection: SolarUser.all.map { |u| [u.email, u.id] }
      f.input :access_level, as: :select, collection: %w[read write admin]
      f.input :status, as: :select, collection: %w[pending approved denied]
      f.input :notes
    end
    f.actions
  end

  member_action :grant_access, method: :put do
    resource.grant_access!
    redirect_to admin_saas_access_managements_path, notice: "Access granted."
  end
end