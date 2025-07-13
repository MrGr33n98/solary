class AddIndexesToSaasMembers < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        unless index_exists?(:saas_members, :user_id)
          add_index :saas_members, :user_id
        end
        unless index_exists?(:saas_members, :plan_id)
          add_index :saas_members, :plan_id
        end
      end
      dir.down do
        remove_index :saas_members, :user_id if index_exists?(:saas_members, :user_id)
        remove_index :saas_members, :plan_id if index_exists?(:saas_members, :plan_id)
      end
    end
  end
end