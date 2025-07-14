class Plan < ApplicationRecord
  has_many :plan_features, dependent: :destroy
  has_many :features, through: :plan_features

  attribute :active, :boolean, default: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name price duration_months description active created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["features"]
  end
end