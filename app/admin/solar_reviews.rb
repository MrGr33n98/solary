ActiveAdmin.register SolarReview do
  permit_params :solar_company_id, :user_id, :rating, :comment, :status, :review_campaign_id, :created_by_id, :updated_by_id

  index do
    selectable_column
    id_column
    column :solar_company
    column :user
    column :rating
    column :comment
    column :status
    column :review_campaign
    column :created_by
    column :updated_by
    actions
  end

  filter :solar_company
  filter :user
  filter :rating
  filter :status
  filter :review_campaign
  filter :created_at
  filter :updated_at
end