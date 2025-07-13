class SaasAccessManagement < ApplicationRecord
  belongs_to :user, class_name: "SolarUser"
  enum access_level: { read: 0, write: 1, admin: 2 }
  enum status: { pending: 0, approved: 1, denied: 2 }
  validates :user_id, presence: true
  validates :access_level, presence: true
  validates :status, presence: true

  def self.ransackable_associations(auth_object = nil)
    ['user']
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[user_id access_level status notes]
  end
end