ActiveAdmin.register SaasSponsored do
  permit_params :solar_company_id, :start_date, :end_date, :budget, :created_by_id, :updated_by_id

  index do
    selectable_column
    id_column
    column :solar_company
    column :start_date
    column :end_date
    column :budget
    column :created_by
    column :updated_by
    actions
  end

  filter :solar_company
  filter :start_date
  filter :end_date
  filter :budget
  filter :created_by
  filter :updated_by
end