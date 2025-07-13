class SolarUser < ApplicationRecord
  self.table_name = "solar_users"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :solar_companies, dependent: :destroy
  has_many :solar_reviews, dependent: :destroy
  has_many :solar_contents, dependent: :destroy
  has_many :review_campaigns, dependent: :destroy
  has_many :badges, as: :badgeable, dependent: :destroy
  has_many :saas_access_managements, foreign_key: :user_id

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role, presence: true
  enum role: { user: 0, moderator: 1, admin: 2 }

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name email role]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end