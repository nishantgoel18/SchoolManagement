module Api
  class SchoolAdminsController < Api::ApplicationController
    before_action :authenticate_user_request!
    before_action :set_school_admin, only: %i[ show edit update destroy ]

    # GET /school_admins or /school_admins.json
    def index
      authorize SchoolAdmin
      @school_admins = SchoolAdmin.includes(:school)
      @school_admins = @school_admins.where(school_id: current_user.school_id) if !current_user.is_admin?
    end

    # GET /school_admins/1 or /school_admins/1.json
    def show
      authorize @school_admin
    end

    # POST /school_admins.json
    def create
      @school_admin = SchoolAdmin.new(school_admin_params)
      authorize @school_admin
      if @school_admin.save
        render json: {}, status: :ok
      else
        render json: {errors: @school_admin.errors.full_messages}, status: 422
      end
    end

    def update
      authorize @school_admin
      if @school_admin.update(school_admin_params)
        render json: {}, status: :ok
      else
        render json: {errors: @school_admin.errors.full_messages}, status: 422
      end
    end

    # DELETE /school_admins/1 or /school_admins/1.json
    def destroy
      authorize @school_admin
      @school_admin.destroy
      render json: {}, status: :ok
    end

    private
      # Use callbacks to share common setup or constraints between actions.

      def set_school_admin
        @school_admin = SchoolAdmin.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def school_admin_params
        params.permit(:school_id, :name, :email, :password)
      end
  end
end
