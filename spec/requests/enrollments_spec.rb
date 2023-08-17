require 'rails_helper'

RSpec.describe "Enrollments", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}
  let(:school) {School.create(name: 'Test school', about: 'Lorem ispum')}
  let(:school_admin) {SchoolAdmin.create(name: 'SchoolAdmin', email: 'school_admin@example.com', password: 'admin123', school: school)}
  let(:student) {Student.create(name: 'Student', email: 'student@example.com', password: 'admin123', school: school)}
  let(:course) {Course.create(name: 'English', school: school)}
  let(:course_2) {Course.create(name: 'Maths', school: school)}

  let(:batch) {Batch.create(name: 'English batch', school_id: school.id, course_id: course.id)}
  let(:batch_2) {Batch.create(name: 'Maths batch', school_id: school.id, course_id: course_2.id)}
  let(:enrollment) {Enrollment.create(batch_id: batch.id, user_id: student.id)}

  let(:valid_attributes) {
    {
      batch_id: batch.id,
      user_id: student.id
    }
  }

  let(:invalid_attributes) {
    {
      batch_id: nil,
      user_id: student.id    
    }
  }

  describe "GET /index" do
    it "renders the enrollments page" do
      cookies[:token] = admin.authentication_token
      get school_enrollments_url(school)
      expect(response.body).to include('Enrollments')
    end
  end

  describe "GET /show" do
    it "renders the enrollment show page" do
      cookies[:token] = admin.authentication_token
      get school_enrollment_url(school, enrollment)
      expect(response.body).to include('Show enrollment')
    end
  end

  describe "GET /new" do
    it "should successfully render the new enrollment page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get new_school_enrollment_url(school)

      expect(response.body).to include('New enrollment')
    end

    it "should successfully render the new enrollment page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get new_school_enrollment_url(school)

      expect(response.body).to include('New enrollment')
    end

    it "should successfully render the new enrollment page when opened with student user" do
      cookies[:token] = student.authentication_token
      get new_school_enrollment_url(school)

      expect(response.body).to include('New enrollment')
    end
  end

  describe "GET /edit" do
    it "should successfully render the edit enrollment page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get edit_school_enrollment_url(school, enrollment)

      expect(response.body).to include('Editing enrollment')
    end

    it "should successfully render the edit enrollment page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get edit_school_enrollment_url(school, enrollment)

      expect(response.body).to include('Editing enrollment')
    end

    it "should not successfully render the edit enrollment page when opened with student user" do
      cookies[:token] = student.authentication_token
      get edit_school_enrollment_url(school, enrollment)
      expect(response.body).not_to include('Editing enrollment')
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Enrollment" do
        cookies[:token] = admin.authentication_token
        expect {
          post school_enrollments_url(school), params: { enrollment: valid_attributes }
        }.to change(Enrollment, :count).by(1)
      end

      it "redirects to the created enrollment" do
        cookies[:token] = admin.authentication_token
        post school_enrollments_url(school), params: { enrollment: valid_attributes }
        expect(response).to redirect_to(school_enrollment_url(school, Enrollment.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new enrollment" do
        cookies[:token] = admin.authentication_token
        expect {
          post school_enrollments_url(school), params: { enrollment: invalid_attributes }
        }.to change(Enrollment, :count).by(0)
      end
    end

    context "with parameters for creating enrollment for same student for same batch again" do
      it "does not create a new enrollment" do
        cookies[:token] = admin.authentication_token
        Enrollment.create(batch_id: batch.id, user_id: student.id)
        expect {
          post school_enrollments_url(school), params: { enrollment: valid_attributes }
        }.to change(Enrollment, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "when admin user tries to update a enrollment with valid parameters" do
      let(:new_attributes) {
        {
          batch_id: batch_2.id,
          user_id: student.id
        }
      }

      it "updates the requested enrollment" do
        cookies[:token] = admin.authentication_token
        patch school_enrollment_url(school, enrollment), params: { enrollment: new_attributes }
        enrollment.reload
        expect(enrollment.batch.name).to eql "Maths batch"
      end

      it "redirects to the enrollment" do
        cookies[:token] = admin.authentication_token
        patch school_enrollment_url(school, enrollment), params: { enrollment: new_attributes }
        enrollment.reload
        expect(response).to redirect_to(school_enrollment_url(school, enrollment))
      end
    end

    context "with invalid parameters" do
      it "does not update the enrollment" do
        cookies[:token] = admin.authentication_token
        patch school_enrollment_url(school, enrollment), params: { enrollment: invalid_attributes }
        expect(response.body).to include('1 error prohibited this enrollment from being saved')
      end
    end

    context "when school admin user tries to update a enrollment with valid parameters" do
      let(:new_attributes) {
        {
          batch_id: batch_2.id,
          user_id: student.id
        }
      }

      it "updates the requested enrollment" do
        cookies[:token] = school_admin.authentication_token
        patch school_enrollment_url(school, enrollment), params: { enrollment: new_attributes }
        enrollment.reload
        expect(enrollment.batch.name).to eql "Maths batch"
      end

      it "redirects to the enrollment" do
        cookies[:token] = school_admin.authentication_token
        patch school_enrollment_url(school, enrollment), params: { enrollment: new_attributes }
        enrollment.reload
        expect(response).to redirect_to(school_enrollment_url(school, enrollment))
      end
    end

    context "with invalid parameters" do
      it "does not update the enrollment" do
        cookies[:token] = school_admin.authentication_token
        patch school_enrollment_url(school, enrollment), params: { enrollment: invalid_attributes }
        expect(response.body).to include('1 error prohibited this enrollment from being saved')
      end
    end
  end

  describe "DELETE /destroy" do
    it "when admin user deletes a school then it redirects to the enrollments list after deleting the enrollment" do
      cookies[:token] = admin.authentication_token
      delete school_enrollment_url(school, enrollment)
      expect(response).to redirect_to(school_enrollments_url(school))
    end

    it "when admin user deletes a school then it redirects to the enrollments list with access denied message" do
      cookies[:token] = admin.authentication_token
      delete school_enrollment_url(school, enrollment)
      expect(response).to redirect_to(school_enrollments_url(school))
    end
  end
end
