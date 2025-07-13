class FeatureGroup < ApplicationRecord
  has_many :saas_access_managements

  def self.ransackable_attributes(_auth_object = nil)
    %w[name description created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['saas_access_managements']
  end
end
