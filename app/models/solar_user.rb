class SolarUser < ApplicationRecord
  self.table_name = "solar_users"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :solar_companies,      dependent: :destroy
  has_many :solar_reviews,        dependent: :destroy
  has_many :solar_contents,       dependent: :destroy
  has_many :review_campaigns,     dependent: :destroy
  has_many :badges,               as: :badgeable, dependent: :destroy
  has_many :saas_access_managements, foreign_key: :user_id
  has_many :notifications,        as: :recipient,
                                   dependent: :destroy,
                                   class_name: "Noticed::Notification"

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :role,  inclusion: { in: %w[admin moderator user] }

  enum role:  { user: 0, moderator: 1, admin: 2 }
  enum status: {
    pending:                     "pending",
    approved:                    "approved",
    cancelled:                   "cancelled",
    awaiting_company_request:    "awaiting_company_request",
    awaiting_product_request:    "awaiting_product_request",
    awaiting_product_approval:   "awaiting_product_approval",
    company_denied:              "company_denied",
    product_denied:              "product_denied"
  }, _default: :pending

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= 'pending'
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name email role status]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[solar_companies solar_reviews solar_contents review_campaigns badges]
  end
end
