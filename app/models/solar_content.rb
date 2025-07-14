class SolarContent < ApplicationRecord
  belongs_to :solar_company
  belongs_to :user
  belongs_to :category, optional: true

  validates :title, presence: true
  validates :body, presence: true
  validates :content_type, inclusion: { in: %w[article guide video] }
  validate :no_curse_words
  validate :created_updated_by_differ_from_user

  scope :by_type, ->(type) { where(content_type: type) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[solar_company_id user_id title content_type body category_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['solar_company', 'user', 'category']
  end

  private

  def no_curse_words
    errors.add(:body, 'contains inappropriate language') if CURSE_WORDS.any? { |w| body&.match?(/\b#{Regexp.escape(w)}\b/i) }
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
