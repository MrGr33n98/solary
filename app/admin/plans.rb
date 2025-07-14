ActiveAdmin.register Plan do
  permit_params :name, :price, :description, :features, :duration_months

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
    column :features do |plan|
      ul do
        if plan.features.present?
          JSON.parse(plan.features).map { |f| li f }
        else
          li "No features defined"
        end
      end
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
    skip_authorization_check only: :index
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
      f.input :features, as: :text, input_html: { rows: 5, value: f.object.features.to_json }
      f.input :duration_months
    end
    f.actions
  end
end
