class SolarReview < ApplicationRecord
  belongs_to :solar_company
  belongs_to :solar_user, optional: true
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
    %w[solar_company_id solar_user_id rating comment status review_campaign_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['solar_company', 'solar_user', 'review_campaign']
  end

  private

  def no_curse_words
    errors.add(:comment, 'contains inappropriate language') if curse_word_found?(comment)
  end

  def curse_word_found?(text)
    CURSE_WORDS.any? { |word| text.match?(Regexp.new("\b#{Regexp.escape(word)}\b", Regexp::IGNORECASE)) }
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
