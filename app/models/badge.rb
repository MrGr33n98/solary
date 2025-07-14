class Badge < ApplicationRecord
  belongs_to :badgeable, polymorphic: true
  has_one_attached :seal

  validates :name, presence: true
  validates :description, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name description badgeable_type badgeable_id]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end