class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= SolarUser.new # Guest user

    can :read, :all if user.present?
    can :manage, :all if user.admin?
    can [:read, :create], [SolarReview, SolarContent] if user.moderator?
    can [:read, :update], SolarCompany do |company|
      company.solar_user_id == user.id
    end
  end
end