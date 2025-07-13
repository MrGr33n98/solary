ActiveAdmin.register SolarContent do
  permit_params :solar_company_id, :user_id, :title, :content_type, :body, :category_id

  index do
    selectable_column
    id_column
    column :solar_company
    column :solar_user
    column :title
    column :content_type
    column :category
    column :created_at
    actions
  end

  filter :solar_company
  filter :solar_user
  filter :title
  filter :content_type
  filter :category
  filter :created_at

  form do |f|
    f.inputs do
      f.input :solar_company
      f.input :solar_user
      f.input :title
      f.input :content_type, as: :select, collection: ['article', 'guide', 'video']
      f.input :body
      f.input :category
    end
    f.actions
  end
end