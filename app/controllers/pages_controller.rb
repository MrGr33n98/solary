class PagesController < ApplicationController
  skip_before_action :authenticate_solar_user!, only: [:home]

  def home
  end

  def about
  end
end
