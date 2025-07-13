class SaasSponsored < ApplicationRecord
  belongs_to :solar_company
  belongs_to :plan

  def self.ransackable_attributes(auth_object = nil)
    %w[active end_date start_date solar_company_id plan_id budget]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[plan solar_company]
  end
end
