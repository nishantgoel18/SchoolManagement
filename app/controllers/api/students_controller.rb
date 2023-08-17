module Api
  class StudentsController < Api::ApplicationController
    before_action :authenticate_user_request!
    before_action :set_student, only: %i[ show edit update destroy ]

    # GET /studentes or /studentes.json
    def index
      authorize Student
      @students = Student.includes(batches: :course, :courses)
      @students = @students.where(school_id: current_user.school_id) if !current_user.is_admin?
    end

    # GET /studentes/1 or /studentes/1.json
    def show
      authorize @student
    end

    # POST /studentes.json
    def create
      @student = Student.new(student_params)
      authorize @student
      if @student.save
        render json: {}, status: :ok
      else
        render json: {errors: @student.errors.full_messages}, status: 422
      end
    end

    def update
      authorize @student
      if @student.update(student_params)
        render json: {}, status: :ok
      else
        render json: {errors: @student.errors.full_messages}, status: 422
      end
    end

    # DELETE /studentes/1 or /studentes/1.json
    def destroy
      authorize @student
      @student.destroy
      render json: {}, status: :ok
    end

    private
      # Use callbacks to share common setup or constraints between actions.

      def set_student
        @student = Student.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def student_params
        params.permit(:school_id, :name, :email, :password)
      end
  end
end
