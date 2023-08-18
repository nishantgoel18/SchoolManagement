require 'rails_helper'

RSpec.describe "Courses", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}
  let(:school) {School.create(name: 'Test school', about: 'Lorem ispum')}
  let(:school_admin) {SchoolAdmin.create(name: 'SchoolAdmin', email: 'school_admin@example.com', password: 'admin123', school: school)}
  let(:student) {Student.create(name: 'Student', email: 'student@example.com', password: 'admin123', school: school)}
  let(:course) {Course.create(name: 'English', school: school)}
  let(:batch) {Batch.create(name: 'English batch', school_id: school.id, course_id: course.id)}

  let(:valid_attributes) {
    {
      name:'English',
      school_id: school.id,
    }
  }

  let(:invalid_attributes) {
    {
      name:'',
      school_id: school.id,
    }
  }

  describe "GET /index" do
    it "renders the courses page" do
      cookies[:token] = admin.authentication_token
      get courses_url()
      expect(response.body).to include('Courses')
    end
  end

  describe "GET /show" do
    it "renders the course show page" do
      cookies[:token] = admin.authentication_token
      get course_url(course)
      expect(response.body).to include('Show course')
    end
  end

  describe "GET /new" do
    it "should successfully render the new course page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get new_course_url

      expect(response.body).to include('New course')
    end

    it "should successfully render the new course page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get new_course_url

      expect(response.body).to include('New course')
    end

    it "should not successfully render the new course page when opened with student user" do
      cookies[:token] = student.authentication_token
      get new_course_url

      expect(response.body).not_to include('New course')
    end
  end

  describe "GET /edit" do
    it "should successfully render the edit course page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get edit_course_url(course)

      expect(response.body).to include('Editing course')
    end

    it "should successfully render the edit course page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get edit_course_url(course)

      expect(response.body).to include('Editing course')
    end

    it "should not successfully render the edit course page when opened with student user" do
      cookies[:token] = student.authentication_token
      get edit_course_url(course)
      expect(response.body).not_to include('Editing course')
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new course" do
        cookies[:token] = admin.authentication_token
        expect {
          post courses_url(), params: { course: valid_attributes }
        }.to change(Course, :count).by(1)
      end

      it "redirects to the created course" do
        cookies[:token] = admin.authentication_token
        post courses_url(), params: { course: valid_attributes }
        expect(response).to redirect_to(course_url(Course.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new course" do
        cookies[:token] = admin.authentication_token
        expect {
          post courses_url(), params: { course: invalid_attributes }
        }.to change(Course, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "when admin user tries to update a course with valid parameters" do
      let(:new_attributes) {
        {
          name:'English honers',
          school_id: school.id,
          course_id: course.id
        }
      }

      it "updates the requested course" do
        cookies[:token] = admin.authentication_token
        patch course_url(course), params: { course: new_attributes }
        course.reload
        expect(course.name).to eql "English honers"
      end

      it "redirects to the course" do
        cookies[:token] = admin.authentication_token
        patch course_url(course), params: { course: new_attributes }
        course.reload
        expect(response).to redirect_to(course_url(course))
      end
    end

    context "with invalid parameters" do
      it "does not update the course" do
        cookies[:token] = admin.authentication_token
        patch course_url(course), params: { course: invalid_attributes }
        expect(response.body).to include('1 error prohibited this course from being saved')
      end
    end

    context "when school admin user tries to update a course with valid parameters" do
      let(:new_attributes) {
        {
          name:'English',
          school_id: school.id,
        }
      }

      it "updates the requested course" do
        cookies[:token] = school_admin.authentication_token
        patch course_url(course), params: { course: new_attributes }
        course.reload
        expect(course.name).to eql "English"
      end

      it "redirects to the course" do
        cookies[:token] = school_admin.authentication_token
        patch course_url(course), params: { course: new_attributes }
        course.reload
        expect(response).to redirect_to(course_url(course))
      end
    end

    context "with invalid parameters" do
      it "does not update the course" do
        cookies[:token] = school_admin.authentication_token
        patch course_url(course), params: { course: invalid_attributes }
        expect(response.body).to include('1 error prohibited this course from being saved')
      end
    end
  end

  describe "DELETE /destroy" do
    it "when admin user deletes a course then it redirects to the courses list after deleting the course" do
      cookies[:token] = admin.authentication_token
      delete course_url(course)
      expect(response).to redirect_to(courses_url())
    end

    it "when admin user deletes a course then it redirects to the courses list with access denied message" do
      cookies[:token] = admin.authentication_token
      delete course_url(course)
      expect(response).to redirect_to(courses_url())
    end
  end
end
