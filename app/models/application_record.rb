class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
