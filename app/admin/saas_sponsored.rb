# ActiveAdmin.register SaasSponsored do
#   permit_params :solar_company_id, :start_date, :end_date, :budget

#   index do
#     selectable_column
#     id_column
#     column :solar_company
#     column :start_date
#     column :end_date
#     column :budget
#     column :created_at
#     actions
#   end

#   filter :solar_company
#   filter :start_date
#   filter :end_date
#   filter :created_at

#   form do |f|
#     f.inputs do
#       f.input :solar_company
#       f.input :start_date, as: :datepicker
#       f.input :end_date, as: :datepicker
#       f.input :budget
#     end
#     f.actions
#   end
# end