class SaasMember < ApplicationRecord
  belongs_to :user, class_name: 'SolarUser'
  belongs_to :plan

  def self.ransackable_attributes(auth_object = nil)
    %w[subscription_status billing_amount billing_date user_id plan_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user plan]
  end
end
