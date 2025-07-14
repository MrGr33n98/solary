ActiveAdmin.register ReviewCampaign do
  controller do
    skip_authorization_check only: :index
  end
  permit_params :solar_company_id, :user_id, :title, :start_date, :end_date

  index do
    selectable_column
    id_column
    column :solar_company
    column :solar_user
    column :title
    column :start_date
    column :end_date
    column :created_at
    actions
  end

  filter :solar_company
  filter :solar_user
  filter :title
  filter :start_date
  filter :end_date
  filter :created_at

  form do |f|
    f.inputs do
      f.input :solar_company
      f.input :solar_user
      f.input :title
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end
    f.actions
  end
end