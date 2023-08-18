require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}
  describe "GET /home" do
    it "returns http success" do
      cookies[:token] = admin.authentication_token
      get "/home"
      expect(response).to have_http_status(:success)
    end

    it "renders home page" do
      cookies[:token] = admin.authentication_token
      get "/home"
      expect(response.body).to include('Welcome to School Management')
    end
  end

end
