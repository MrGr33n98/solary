class RemoveFeaturesColumnFromPlans < ActiveRecord::Migration[7.0]
  def change
    remove_column :plans, :features, :text
  end
end
