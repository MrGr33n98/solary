ActiveAdmin.register SolarUser do
  permit_params :email, :name, :role, :created_by_id, :updated_by_id

  filter :email
  filter :role, as: :select, collection: SolarUser.roles.keys
  filter :name
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :role
    column :created_at
    actions
  end
  member_action :promote_to_admin, method: :put do
    resource.update(role: :admin)
    redirect_to admin_solar_users_path, notice: 'User promoted to admin successfully'
  end
  controller do
    def scoped_collection
      if current_admin_user && current_admin_user.solar_user&.role == 'admin'
        super
      else
        super.where(role: 'user')
      end
    end
  end
  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :role, as: :select, collection: SolarUser.roles.keys
      f.input :created_by_id, as: :select, collection: SolarUser.all.map { |su| [su.email, su.id] }
      f.input :updated_by_id, as: :select, collection: SolarUser.all.map { |su| [su.email, su.id] }
    end
    f.actions
  end
end
