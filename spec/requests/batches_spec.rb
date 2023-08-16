require 'rails_helper'

RSpec.describe "Batches", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}
  let(:school) {School.create(name: 'Test school', about: 'Lorem ispum')}
  let(:school_admin) {SchoolAdmin.create(name: 'SchoolAdmin', email: 'school_admin@example.com', password: 'admin123', school: school)}
  let(:student) {Student.create(name: 'Student', email: 'student@example.com', password: 'admin123', school: school)}
  let(:course) {Course.create(name: 'English', school: school)}
  let(:batch) {Batch.create(name: 'English batch', school_id: school.id, course_id: course.id)}

  let(:valid_attributes) {
    {
      name:'English Batch',
      school_id: school.id,
      course_id: course.id
    }
  }

  let(:invalid_attributes) {
    {
      name:'',
      school_id: school.id,
      course_id: course.id    
    }
  }

  describe "GET /index" do
    it "renders the batches page" do
      cookies[:token] = admin.authentication_token
      get school_batches_url(school)
      expect(response.body).to include('Batches')
    end
  end

  describe "GET /show" do
    it "renders the batch show page" do
      cookies[:token] = admin.authentication_token
      get school_batch_url(school, batch)
      expect(response.body).to include('Show batch')
    end
  end

  describe "GET /new" do
    it "should successfully render the new batch page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get new_school_batch_url(school)

      expect(response.body).to include('New batch')
    end

    it "should successfully render the new batch page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get new_school_batch_url(school)

      expect(response.body).to include('New batch')
    end

    it "should not successfully render the new school page when opened with student user" do
      cookies[:token] = student.authentication_token
      get new_school_batch_url(school)

      expect(response.body).not_to include('New batch')
    end
  end

  describe "GET /edit" do
    it "should successfully render the edit batch page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get edit_school_batch_url(school, batch)

      expect(response.body).to include('Editing batch')
    end

    it "should successfully render the edit batch page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get edit_school_batch_url(school, batch)

      expect(response.body).to include('Editing batch')
    end

    it "should not successfully render the edit school page when opened with student user" do
      cookies[:token] = student.authentication_token
      get edit_school_batch_url(school, batch)
      expect(response.body).not_to include('Editing batch')
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Batch" do
        cookies[:token] = admin.authentication_token
        expect {
          post school_batches_url(school), params: { batch: valid_attributes }
        }.to change(Batch, :count).by(1)
      end

      it "redirects to the created batch" do
        cookies[:token] = admin.authentication_token
        post school_batches_url(school), params: { batch: valid_attributes }
        expect(response).to redirect_to(school_batch_url(school, Batch.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new batch" do
        cookies[:token] = admin.authentication_token
        expect {
          post school_batches_url(school), params: { batch: invalid_attributes }
        }.to change(Batch, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "when admin user tries to update a school with valid parameters" do
      let(:new_attributes) {
        {
          name:'English Batch',
          school_id: school.id,
          course_id: course.id
        }
      }

      it "updates the requested school" do
        cookies[:token] = admin.authentication_token
        patch school_batch_url(school, batch), params: { batch: new_attributes }
        batch.reload
        expect(batch.name).to eql "English Batch"
      end

      it "redirects to the school" do
        cookies[:token] = admin.authentication_token
        patch school_batch_url(school, batch), params: { batch: new_attributes }
        batch.reload
        expect(response).to redirect_to(school_batch_url(school, batch))
      end
    end

    context "with invalid parameters" do
      it "does not update the school" do
        cookies[:token] = admin.authentication_token
        patch school_batch_url(school, batch), params: { batch: invalid_attributes }
        expect(response.body).to include('1 error prohibited this batch from being saved')
      end
    end

    context "when school admin user tries to update a school with valid parameters" do
      let(:new_attributes) {
        {
          name:'English Batch',
          school_id: school.id,
          course_id: course.id
        }
      }

      it "updates the requested school" do
        cookies[:token] = school_admin.authentication_token
        patch school_batch_url(school, batch), params: { batch: new_attributes }
        batch.reload
        expect(batch.name).to eql "English Batch"
      end

      it "redirects to the school" do
        cookies[:token] = school_admin.authentication_token
        patch school_batch_url(school, batch), params: { batch: new_attributes }
        batch.reload
        expect(response).to redirect_to(school_batch_url(school, batch))
      end
    end

    context "with invalid parameters" do
      it "does not update the school" do
        cookies[:token] = school_admin.authentication_token
        patch school_batch_url(school, batch), params: { batch: invalid_attributes }
        expect(response.body).to include('1 error prohibited this batch from being saved')
      end
    end
  end

  describe "DELETE /destroy" do
    it "when admin user deletes a school then it redirects to the batches list after deleting the batch" do
      cookies[:token] = admin.authentication_token
      delete school_batch_url(school, batch)
      expect(response).to redirect_to(school_batches_url(school))
    end

    it "when admin user deletes a school then it redirects to the batches list with access denied message" do
      cookies[:token] = admin.authentication_token
      delete school_batch_url(school, batch)
      expect(response).to redirect_to(school_batches_url(school))
    end
  end
end
