module Api
  module V1
    class PlansController < ApplicationController
      def index
        render json: Plan.all.map { |p| { id: p.id, name: p.name, price: p.price, duration_months: p.duration_months, features: p.features } }
      end
    end
  end
end
