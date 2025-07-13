class Category < ApplicationRecord
  has_many :solar_contents, dependent: :nullify

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['solar_contents']
  end
end