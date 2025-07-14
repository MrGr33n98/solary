class PagesController < ApplicationController
  skip_before_action :authenticate_solar_user!, only: [:home]
  skip_authorization_check only: [:home]

  def home
  end

  def about
  end
end
