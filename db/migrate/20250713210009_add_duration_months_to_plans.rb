class AddDurationMonthsToPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :plans, :duration_months, :integer
  end
end
