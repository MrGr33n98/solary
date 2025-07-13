ActiveAdmin.register SolarCompany do
  permit_params :name, :location, :installed_capacity_mw, :status, :user_id, :certifications, photos: []

  index do
    selectable_column
    id_column
    column :name
    column :location
    column :installed_capacity_mw
    column :status
    column :solar_user
    column :created_at
    actions
  end

  filter :name
  filter :location
  filter :installed_capacity_mw
  filter :status
  filter :solar_user
  filter :created_at

  show do
    attributes_table do
      row :name
      row :location
      row :installed_capacity_mw
      row :status
      row :solar_user
      row :certifications
      row :created_at
      row :updated_at
      row :photos do |company|
        ul do
          company.photos.each do |photo|
            li do
              image_tag url_for(photo), size: "150x150"
            end
          end
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :location
      f.input :installed_capacity_mw
      f.input :status, as: :select, collection: ['active', 'inactive', 'pending']
      f.input :solar_user
      f.input :certifications
      f.input :photos, as: :file, input_html: { multiple: true }
    end
    f.actions
  end
end