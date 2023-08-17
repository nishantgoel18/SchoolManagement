require 'rails_helper'

RSpec.describe "Students", type: :request do
  let(:admin) {Admin.create(name: 'Admin', email: 'admin@example.com', password: 'admin123')}
  let(:school) {School.create(name: 'Test school', about: 'Lorem ispum')}
  let(:school_admin) {SchoolAdmin.create(name: 'SchoolAdmin', email: 'school_admin@example.com', password: 'admin123', school: school)}
  let(:student) {Student.create(name: 'Student', email: 'student@example.com', password: 'admin123', school: school)}

  let(:valid_attributes) {
    {
      name:'Student',
      email: "student_#{rand(9999)}@example.com",
      password: 'user123',
      school_id: school.id,
    }
  }

  let(:invalid_attributes) {
    {
      name:'',
      email: "student_#{rand(9999)}@example.com",
      password: 'user123',
      school_id: school.id,
    }
  }

  describe "GET /index" do
    it "renders the students page" do
      cookies[:token] = admin.authentication_token
      get students_url
      expect(response.body).to include('Students')
    end
  end

  describe "GET /show" do
    it "renders the student show page" do
      cookies[:token] = admin.authentication_token
      get student_url(student)
      expect(response.body).to include('Show student')
    end
  end

  describe "GET /new" do
    it "should successfully render the new student page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get new_student_url

      expect(response.body).to include('New student')
    end

    it "should not successfully render the new student page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get new_student_url

      expect(response.body).not_to include('New student')
    end

    it "should not successfully render the new student page when opened with student user" do
      cookies[:token] = student.authentication_token
      get new_student_url

      expect(response.body).not_to include('New student')
    end
  end

  describe "GET /edit" do
    it "should successfully render the edit student page when opened with admin user" do
      cookies[:token] = admin.authentication_token
      get edit_student_url(student)

      expect(response.body).to include('Editing student')
    end

    it "should not successfully render the edit student page when opened with school admin user" do
      cookies[:token] = school_admin.authentication_token
      get edit_student_url(student)

      expect(response.body).not_to include('Editing student')
    end

    it "should not successfully render the edit student page when opened with student user" do
      cookies[:token] = student.authentication_token
      get edit_student_url(student)
      expect(response.body).not_to include('Editing student')
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new student" do
        cookies[:token] = admin.authentication_token
        expect {
          post students_url, params: { student: valid_attributes }
        }.to change(Student, :count).by(1)
      end

      it "redirects to the created student" do
        cookies[:token] = admin.authentication_token
        post students_url, params: { student: valid_attributes }
        expect(response).to redirect_to(student_url(Student.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new student" do
        cookies[:token] = admin.authentication_token
        expect {
          post students_url, params: { student: invalid_attributes }
        }.to change(Student, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "when admin user tries to update a student with valid parameters" do
      let(:new_attributes) {
        {
          name:'Harry',
          school_id: school.id,
          emai: student.email,
        }
      }

      it "updates the requested student" do
        cookies[:token] = admin.authentication_token
        patch student_url(student), params: { student: new_attributes }
        student.reload
        expect(student.name).to eql "Harry"
      end

      it "redirects to the student" do
        cookies[:token] = admin.authentication_token
        patch student_url(student), params: { student: new_attributes }
        student.reload
        expect(response).to redirect_to(student_url(student))
      end
    end

    context "with invalid parameters" do
      it "does not update the student" do
        cookies[:token] = admin.authentication_token
        patch student_url(student), params: { student: invalid_attributes }
        expect(response.body).to include('1 error prohibited this student from being saved')
      end
    end
  end

  describe "DELETE /destroy" do
    it "when admin user deletes a student then it redirects to the students list after deleting the student" do
      cookies[:token] = admin.authentication_token
      delete student_url(student)
      expect(response).to redirect_to(students_url)
    end

    it "when admin user deletes a student then it redirects to the students list with access denied message" do
      cookies[:token] = admin.authentication_token
      delete student_url(student)
      expect(response).to redirect_to(students_url)
    end
  end
end
