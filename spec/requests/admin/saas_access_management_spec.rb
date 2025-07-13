require 'rails_helper'

RSpec.describe "Admin Saas Access Management", type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:saas_access_management) { create(:saas_access_management) }

  before do
    sign_in admin_user
  end

  describe "GET /admin/saas_access_managements" do
    it "returns success" do
      get admin_saas_access_managements_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /admin/saas_access_management (if custom route)" do
    it "redirects to index or renders successfully" do
      get '/admin/saas_access_management'
      expect(response).to have_http_status(:ok) # or :redirect if redirecting
    end
  end
end