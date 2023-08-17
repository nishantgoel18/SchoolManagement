module Api
  class BatchesController < Api::ApplicationController
    before_action :authenticate_user_request!
    before_action :set_school
    before_action :set_batch, only: %i[ show edit update destroy ]

    # GET /batches or /batches.json
    def index
      authorize Batch
      @batches = Batch.includes(:school, :students)
      @batches = @batches.where(school_id: @school.id)
    end

    # GET /batches/1 or /batches/1.json
    def show
      authorize @batch
    end

    # POST /batches.json
    def create
      @batch = Batch.new(batch_params)
      authorize @batch
      if @batch.save
        render json: {}, status: :ok
      else
        render json: {errors: @batch.errors.full_messages}, status: 422
      end
    end

    def update
      authorize @batch
      if @batch.update(batch_params)
        render json: {}, status: :ok
      else
        render json: {errors: @batch.errors.full_messages}, status: 422
      end
    end

    # DELETE /batches/1 or /batches/1.json
    def destroy
      authorize @batch
      @batch.destroy
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

      def set_batch
        @batch = Batch.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def batch_params
        params.permit(:school_id, :course_id, :name)
      end
  end
end
