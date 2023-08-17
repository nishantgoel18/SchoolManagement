require 'rails_helper'

RSpec.describe "Schools", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}

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
      user = double('current_user')

      School.create! valid_attributes
      binding.pry
      get schools_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      school = School.create! valid_attributes
      get school_url(school)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_school_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      school = School.create! valid_attributes
      get edit_school_url(school)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new School" do
        expect {
          post schools_url, params: { school: valid_attributes }
        }.to change(School, :count).by(1)
      end

      it "redirects to the created school" do
        post schools_url, params: { school: valid_attributes }
        expect(response).to redirect_to(school_url(School.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new School" do
        expect {
          post schools_url, params: { school: invalid_attributes }
        }.to change(School, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post schools_url, params: { school: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested school" do
        school = School.create! valid_attributes
        patch school_url(school), params: { school: new_attributes }
        school.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the school" do
        school = School.create! valid_attributes
        patch school_url(school), params: { school: new_attributes }
        school.reload
        expect(response).to redirect_to(school_url(school))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        school = School.create! valid_attributes
        patch school_url(school), params: { school: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested school" do
      school = School.create! valid_attributes
      expect {
        delete school_url(school)
      }.to change(School, :count).by(-1)
    end

    it "redirects to the schools list" do
      school = School.create! valid_attributes
      delete school_url(school)
      expect(response).to redirect_to(schools_url)
    end
  end
end
