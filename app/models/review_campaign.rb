class ReviewCampaign < ApplicationRecord
  belongs_to :solar_company
  belongs_to :solar_user, optional: true

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validate :created_updated_by_differ_from_user

  scope :active, -> { where('start_date <= ? AND end_date >= ?', Time.current, Time.current) }
  scope :expired, -> { where('end_date < ?', Time.current) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[solar_company_id solar_user_id title start_date end_date]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['solar_company', 'solar_user']
  end

  private

  def end_date_after_start_date
    errors.add(:end_date, "must be after start date") if end_date <= start_date
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