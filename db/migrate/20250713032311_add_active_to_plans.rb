class AddActiveToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :active, :boolean
  end
end
