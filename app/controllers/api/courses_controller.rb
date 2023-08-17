module Api
  class CoursesController < Api::ApplicationController
    before_action :authenticate_user_request!
    before_action :set_course, only: %i[ show edit update destroy ]

    # GET /coursees or /coursees.json
    def index
      authorize Course
      @courses = Course.includes(school: :batches)
      @courses = @courses.where(school_id: current_user.school_id) if current_user.is_school_admin?
    end

    # GET /coursees/1 or /coursees/1.json
    def show
      authorize @course
    end

    # POST /coursees.json
    def create
      @course = Course.new(course_params)
      authorize @course
      if @course.save
        render json: {}, status: :ok
      else
        render json: {errors: @course.errors.full_messages}, status: 422
      end
    end

    def update
      authorize @course
      if @course.update(course_params)
        render json: {}, status: :ok
      else
        render json: {errors: @course.errors.full_messages}, status: 422
      end
    end

    # DELETE /coursees/1 or /coursees/1.json
    def destroy
      authorize @course
      @course.destroy
      render json: {}, status: :ok
    end

    private
      # Use callbacks to share common setup or constraints between actions.

      def set_course
        @course = Course.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def course_params
        params.permit(:school_id, :name)
      end
  end
end
