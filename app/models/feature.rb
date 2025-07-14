class Feature < ApplicationRecord
  has_many :plan_features, dependent: :destroy
  has_many :plans, through: :plan_features

  validates :name, presence: true, uniqueness: true

  attribute :active, :boolean, default: true
  scope :active, -> { where(active: true) }

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description active created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end