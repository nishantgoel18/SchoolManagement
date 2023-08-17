module Api
  class SchoolsController < Api::ApplicationController
    before_action :authenticate_user_request!
    before_action :set_school, only: %i[ show edit update destroy ]

    # GET /schools or /schools.json
    def index
      authorize School
      @schools = School.includes(:batches, :courses, :school_admins)
      @schools = @schools.where(school_id: current_user.school_id) if !current_user.is_admin?
    end

    # GET /schools/1 or /schools/1.json
    def show
      authorize @school
    end

    # POST /schools.json
    def create
      @school = School.new(school_params)
      authorize @school
      if @school.save
        render json: {}, status: :ok
      else
        render json: {errors: @school.errors.full_messages}, status: 422
      end
    end

    def update
      authorize @school
      if @school.update(school_params)
        render json: {}, status: :ok
      else
        render json: {errors: @school.errors.full_messages}, status: 422
      end
    end

    # DELETE /schools/1 or /schools/1.json
    def destroy
      authorize @school
      @school.destroy
      render json: {}, status: :ok
    end

    private
      # Use callbacks to share common setup or constraints between actions.

      def set_school
        @school = School.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def school_params
        params.permit(:name, :about, :address)
      end
  end
end
