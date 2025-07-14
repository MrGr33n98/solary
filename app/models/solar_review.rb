class SolarReview < ApplicationRecord
  belongs_to :solar_company
  belongs_to :user
  belongs_to :review_campaign, optional: true

  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, presence: true
  validate :no_curse_words
  validate :created_updated_by_differ_from_user

  scope :approved, -> { where(status: 'approved') }
  scope :pending, -> { where(status: 'pending') }
  scope :rejected, -> { where(status: 'rejected') }

  enum status: { pending: 0, approved: 1, rejected: 2 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[solar_company_id user_id rating comment status review_campaign_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['solar_company', 'user', 'review_campaign']
  end

  private

  def no_curse_words
    errors.add(:comment, 'contains inappropriate language') if CURSE_WORDS.any? { |w| comment&.match?(/\b#{Regexp.escape(w)}\b/i) }
  end

  def created_updated_by_differ_from_user
    if created_by_id == user_id
      errors.add(:created_by_id, "cannot be the same as user_id")
    end
    if updated_by_id == user_id
      errors.add(:updated_by_id, "cannot be the same as user_id")
    end
  end
end