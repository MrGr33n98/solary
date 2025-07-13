module Api
  module V1
    class SaasMembersController < ApplicationController
      def index
        @saas_members = SaasMember.all
        render json: @saas_members.as_json(include: [:user, :plan])
      end
    end
  end
end
