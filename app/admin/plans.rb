ActiveAdmin.register Plan do
  permit_params :name, :price, :description, :duration_months, feature_ids: []

  filter :name
  filter :price
  filter :duration_months
  index do
    selectable_column
    id_column
    column :name
    column :price do |plan|
      number_to_currency(plan.price)
    end
    column :duration_months
    column 'Features' do |plan|
      plan.features.pluck(:name).join(", ")
    end
    column :description
    column :created_at
    actions
  end
  member_action :activate_plan, method: :put do
    resource.update(active: true) # Add `active` boolean if needed, or adjust logic
    redirect_to admin_plans_path, notice: 'Plan activated successfully'
  end
  controller do
    skip_authorization_check
    def scoped_collection
      if current_admin_user && current_admin_user.solar_user&.role == 'admin'
        super
      else
        super.where(active: true) # Adjust if `active` column is added
      end
    end
  end
  form do |f|
    f.inputs "Planos e Preços" do
      f.input :name
      f.input :price
      f.input :description, as: :text
      f.input :duration_months
      f.input :features, as: :check_boxes, collection: Feature.all.map { |feature| [feature.name.humanize, feature.id] }
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :price do |plan|
        number_to_currency(plan.price)
      end
      row :duration_months
      row :description
      row :created_at
      row :updated_at
    end

    panel "Features" do
      ul do
        plan.features.each { |f| li f.name }
      end
    end
  end
end
