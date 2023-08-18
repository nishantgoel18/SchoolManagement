require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}

  describe "GET /login" do
    it "renders the login page" do
      get new_login_url
      expect(response.body).to include('User Log in')
    end  
  end

  describe "POST /login" do
    context "with valid login credentials" do

      it "redirects to the home page" do
        post login_user_url, params: { email: admin.email, password: 'admin123' }
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
