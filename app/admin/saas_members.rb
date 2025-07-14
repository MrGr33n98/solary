ActiveAdmin.register SaasMember do
  controller do
    skip_authorization_check only: :index
  end
  permit_params :user_id, :plan_id, :subscription_status, :billing_amount, :billing_date

  filter :user
  filter :plan
  filter :subscription_status, as: :select, collection: ['active', 'inactive', 'pending']
  filter :billing_amount
  filter :billing_date

  index do
    selectable_column
    id_column
    column :user
    column :plan
    column :subscription_status
    column :billing_amount
    column :billing_date
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :plan
      f.input :subscription_status, as: :select, collection: ['active', 'inactive', 'pending']
      f.input :billing_amount
      f.input :billing_date, as: :datepicker
    end
    f.actions
  end

  member_action :activate_subscription, method: :put do
    resource.update(subscription_status: 'active')
    redirect_to admin_saas_members_path, notice: 'Subscription activated successfully'
  end

  member_action :update_billing, method: :put do
    # Implement billing update logic here
    redirect_to admin_saas_members_path, notice: 'Billing updated successfully'
  end
end
