require 'rails_helper'

RSpec.describe "SchoolAdmins", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}
  let(:school) {School.create(name: 'Test school', about: 'Lorem ispum')}
  let(:school_admin) {SchoolAdmin.create(name: 'SchoolAdmin', email: 'school_admin@example.com', password: 'admin123', school: school)}
  let(:student) {Student.create(name: 'Student', email: 'student@example.com', password: 'admin123', school: school)}

  let(:valid_attributes) {
    {
      name:'SchoolAdmin',
      email: "school_admin_#{rand(9999)}@example.com",
      password: 'user123',
      school_id: school.id,
    }
  }

  let(:invalid_attributes) {
    {
      name:'',
      email: "school_admin_#{rand(9999)}@example.com",
      password: 'user123',
      school_id: school.id,
    }
  }

  describe "GET /index" do
    it "renders the school_admins page" do
      cookies[:token] = admin.authentication_token
      get school_admins_url
      expect(response.body).to include('School Admins')
    end
  end

  describe "GET /show" do
    it "renders the school_admin show page" do
      cookies[:token] = admin.authentication_token
      get school_admin_url(school_admin)
      expect(response.body).to include('Show school admin')
    end
  end

  describe "GET /new" do
    it "should successfully render the new school_admin page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get new_school_admin_url

      expect(response.body).to include('New school admin')
    end

    it "should successfully render the new school_admin page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get new_school_admin_url

      expect(response.body).not_to include('New school admin')
    end

    it "should not successfully render the new school_admin page when opened with school_admin user" do
      cookies[:token] = school_admin.authentication_token
      get new_school_admin_url

      expect(response.body).not_to include('New school admin')
    end
  end

  describe "GET /edit" do
    it "should successfully render the edit school_admin page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get edit_school_admin_url(school_admin)

      expect(response.body).to include('Editing school admin')
    end

    it "should successfully render the edit school_admin page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get edit_school_admin_url(school_admin)

      expect(response.body).not_to include('Editing school admin')
    end

    it "should not successfully render the edit school_admin page when opened with school_admin user" do
      cookies[:token] = school_admin.authentication_token
      get edit_school_admin_url(school_admin)
      expect(response.body).not_to include('Editing school admin')
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new school_admin" do
        cookies[:token] = admin.authentication_token
        expect {
          post school_admins_url, params: { school_admin: valid_attributes }
        }.to change(SchoolAdmin, :count).by(1)
      end

      it "redirects to the created school_admin" do
        cookies[:token] = admin.authentication_token
        post school_admins_url, params: { school_admin: valid_attributes }
        expect(response).to redirect_to(school_admin_url(SchoolAdmin.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new school_admin" do
        cookies[:token] = admin.authentication_token
        expect {
          post school_admins_url, params: { school_admin: invalid_attributes }
        }.to change(SchoolAdmin, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "when admin user tries to update a school_admin with valid parameters" do
      let(:new_attributes) {
        {
          name:'Harry',
          school_id: school.id,
          emai: school_admin.email,
        }
      }

      it "updates the requested school_admin" do
        cookies[:token] = admin.authentication_token
        patch school_admin_url(school_admin), params: { school_admin: new_attributes }
        school_admin.reload
        expect(school_admin.name).to eql "Harry"
      end

      it "redirects to the school_admin" do
        cookies[:token] = admin.authentication_token
        patch school_admin_url(school_admin), params: { school_admin: new_attributes }
        school_admin.reload
        expect(response).to redirect_to(school_admin_url(school_admin))
      end
    end

    context "with invalid parameters" do
      it "does not update the school_admin" do
        cookies[:token] = admin.authentication_token
        patch school_admin_url(school_admin), params: { school_admin: invalid_attributes }
        expect(response.body).to include('1 error prohibited this school_admin from being saved')
      end
    end
  end

  describe "DELETE /destroy" do
    it "when admin user deletes a school_admin then it redirects to the school_admins list after deleting the school_admin" do
      cookies[:token] = admin.authentication_token
      delete school_admin_url(school_admin)
      expect(response).to redirect_to(school_admins_url)
    end

    it "when admin user deletes a school_admin then it redirects to the school_admins list with access denied message" do
      cookies[:token] = admin.authentication_token
      delete school_admin_url(school_admin)
      expect(response).to redirect_to(school_admins_url)
    end
  end
end
