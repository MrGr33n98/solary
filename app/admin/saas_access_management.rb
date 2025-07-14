ActiveAdmin.register SaasAccessManagement do
  controller do
    skip_authorization_check only: :index
  end
  menu priority: 2, label: "Saas Access Management"
  permit_params :user_id, :plan, :status

  index do
    selectable_column
    id_column
    column :user
    column :access_level
    column :status
    column :notes
    actions
  end

  filter :user_id, as: :select, collection: -> { SolarUser.all.map { |u| [u.email, u.id] } }
  filter :access_level
  filter :status
  filter :notes

  form do |f|
    f.inputs do
      f.input :user_id, as: :select, collection: -> { SolarUser.all.map { |u| [u.name, u.id] } }
      f.input :plan
      f.input :status
    end
    f.actions
  end

  member_action :grant_access, method: :put do
    resource.grant_access!
    redirect_to admin_saas_access_managements_path, notice: "Access granted."
  end
end