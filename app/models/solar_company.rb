class SolarCompany < ApplicationRecord
  has_many_attached :photos
  belongs_to :solar_user, optional: true
  has_many :solar_reviews, dependent: :destroy
  has_many :solar_contents, dependent: :destroy
  has_many :review_campaigns, dependent: :destroy
  has_many :badges, as: :badgeable, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :installed_capacity_mw, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[active inactive pending] }
  validate :created_updated_by_differ_from_user

  scope :active, -> { where(status: 'active') }
  scope :inactive, -> { where(status: 'inactive') }
  scope :pending, -> { where(status: 'pending') }

  def average_rating
    solar_reviews.average(:rating).to_f.round(2)
  end

  def customer_satisfaction
    if average_rating >= 4.0
      "Very Satisfied"
    elsif average_rating >= 3.0
      "Satisfied"
    else
      "Needs Improvement"
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name location installed_capacity_mw status solar_user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['solar_user', 'solar_reviews', 'solar_contents', 'review_campaigns', 'badges']
  end

  private

  def created_updated_by_differ_from_user
    if created_by_id == user_id
      errors.add(:created_by_id, "cannot be the same as user_id")
    end
    if updated_by_id == user_id
      errors.add(:updated_by_id, "cannot be the same as user_id")
    end
  end
end