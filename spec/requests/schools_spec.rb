require 'rails_helper'

RSpec.describe "Schools", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}
  let(:school) {School.create(name: 'Test school', about: 'Lorem ispum')}
  let(:school_admin) {SchoolAdmin.create(name: 'SchoolAdmin', email: 'school_admin@example.com', password: 'admin123', school: school)}
  let(:student) {Student.create(name: 'Student', email: 'student@example.com', password: 'admin123', school: school)}

  let(:valid_attributes) {
    {
      name:'Abc',
      address: 'lorem ispum',
      about: 'lorem ispum'    
    }
  }

  let(:invalid_attributes) {
    {
      name:'',
      address: 'lorem ispum',
      about: 'lorem ispum'    
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      cookies[:token] = admin.authentication_token
      get schools_url
      expect(response.body).to include('Schools')
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      cookies[:token] = admin.authentication_token
      get school_url(school)
      expect(response.body).to include('Show school')
    end
  end

  describe "GET /new" do
    it "should successfully render the new school page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get new_school_url

      expect(response.body).to include('New school')
    end

    it "should not successfully render the new school page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get new_school_url

      expect(response.body).not_to include('New school')
    end

    it "should not successfully render the new school page when opened with student user" do
      cookies[:token] = student.authentication_token
      get new_school_url

      expect(response.body).not_to include('New school')
    end
  end

  describe "GET /edit" do
    it "should successfully render the edit school page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get edit_school_url(school)

      expect(response.body).to include('Editing school')
    end

    it "should not successfully render the edit school page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get edit_school_url(school)

      expect(response.body).to include('Editing school')
    end

    it "should not successfully render the edit school page when opened with student user" do
      cookies[:token] = student.authentication_token
      get edit_school_url(school)
      expect(response.body).not_to include('Editing school')
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new School" do
        cookies[:token] = admin.authentication_token
        expect {
          post schools_url, params: { school: valid_attributes }
        }.to change(School, :count).by(1)
      end

      it "redirects to the created school" do
        cookies[:token] = admin.authentication_token
        post schools_url, params: { school: valid_attributes }
        expect(response).to redirect_to(school_url(School.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new School" do
        cookies[:token] = admin.authentication_token
        expect {
          post schools_url, params: { school: invalid_attributes }
        }.to change(School, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "when admin user tries to update a school with valid parameters" do
      let(:new_attributes) {
        {
          name: 'Peters high school', address: 'Lorem ispum', about: 'Lorem ispum'
        }
      }

      it "updates the requested school" do
        cookies[:token] = admin.authentication_token
        patch school_url(school), params: { school: new_attributes }
        school.reload
        expect(school.name).to eql "Peters high school"
      end

      it "redirects to the school" do
        cookies[:token] = admin.authentication_token
        patch school_url(school), params: { school: new_attributes }
        school.reload
        expect(response).to redirect_to(school_url(school))
      end
    end

    context "with invalid parameters" do
      it "does not update the school" do
        cookies[:token] = admin.authentication_token
        patch school_url(school), params: { school: invalid_attributes }
        expect(response.body).to include('1 error prohibited this school from being saved')
      end
    end

    context "when school admin user tries to update a school with valid parameters" do
      let(:new_attributes) {
        {
          name: 'Peters high school', address: 'Lorem ispum', about: 'Lorem ispum'
        }
      }

      it "updates the requested school" do
        cookies[:token] = school_admin.authentication_token
        patch school_url(school), params: { school: new_attributes }
        school.reload
        expect(school.name).to eql "Peters high school"
      end

      it "redirects to the school" do
        cookies[:token] = school_admin.authentication_token
        patch school_url(school), params: { school: new_attributes }
        school.reload
        expect(response).to redirect_to(school_url(school))
      end
    end

    context "with invalid parameters" do
      it "does not update the school" do
        cookies[:token] = school_admin.authentication_token
        patch school_url(school), params: { school: invalid_attributes }
        expect(response.body).to include('1 error prohibited this school from being saved')
      end
    end
  end

  describe "DELETE /destroy" do
    it "when admin user deletes a school then it redirects to the schools list after deleting the school" do
      cookies[:token] = admin.authentication_token
      delete school_url(school)
      expect(response).to redirect_to(schools_url)
    end

    it "when admin user deletes a school then it redirects to the schools list with access denied message" do
      cookies[:token] = admin.authentication_token
      delete school_url(school)
      expect(response).to redirect_to(schools_url)
    end
  end
end
