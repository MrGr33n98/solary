require 'cancan'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_solar_user!
  before_action :set_unread_notifications

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Acesso negado: #{exception.message}"
    redirect_to root_path
  end

  def current_user
    current_solar_user
  end
  
  helper_method :current_user

  private

  def set_unread_notifications
    if current_solar_user
      @unread = Noticed::Notification.where(recipient: current_solar_user, read_at: nil)
      @read = Noticed::Notification.where(recipient: current_solar_user).where.not(read_at: nil)
    else
      @unread = []
      @read = []
    end
  end
end
