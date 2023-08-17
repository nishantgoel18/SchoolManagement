module Api
  class EnrollmentsController < Api::ApplicationController
    before_action :authenticate_user_request!
    before_action :set_school
    before_action :set_enrollment, only: %i[ show edit update destroy ]

    # GET /enrollmentes or /enrollmentes.json
    def index
      authorize Enrollment
      @enrollments = Enrollment.includes(batch: :course, :student)
      @enrollments = @enrollments.where(batch_id: @school.batches)
      @enrollments = @enrollments.where(user_id: current_user.id) if current_user.is_student?
    end

    # GET /enrollmentes/1 or /enrollmentes/1.json
    def show
      authorize @enrollment
    end

    # POST /enrollmentes.json
    def create
      @enrollment = Enrollment.new(enrollment_params)
      authorize @enrollment
      if @enrollment.save
        render json: {}, status: :ok
      else
        render json: {errors: @enrollment.errors.full_messages}, status: 422
      end
    end

    def update
      authorize @enrollment
      if @enrollment.update(enrollment_params)
        render json: {}, status: :ok
      else
        render json: {errors: @enrollment.errors.full_messages}, status: 422
      end
    end

    # DELETE /enrollmentes/1 or /enrollmentes/1.json
    def destroy
      authorize @enrollment
      @enrollment.destroy
      render json: {}, status: :ok
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_school
        @school = School.find_by(id: params[:school_id])
        if @school.blank?
          render json: {error: 'School not found', status: 422}, status: 422
        end
      end

      def set_enrollment
        @enrollment = Enrollment.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def enrollment_params
        params.permit(:batch_id, :user_id, :status)
      end
  end
end
