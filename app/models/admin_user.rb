class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  belongs_to :solar_user, optional: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email created_at updated_at solar_user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['solar_user']
  end
end
