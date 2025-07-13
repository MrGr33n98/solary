class Api::V1::SolarUsersController < ApplicationController
  def index
    @solar_users = SolarUser.all
    render json: @solar_users
  end
end
