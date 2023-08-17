class BatchesController < ApplicationController
  before_action :authenticate_user!
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

  # GET /batches/new
  def new
    @batch = Batch.new
    authorize @batch
  end

  # GET /batches/1/edit
  def edit
    authorize @batch
  end

  # POST /batches or /batches.json
  def create
    @batch = Batch.new(batch_params)
    authorize @batch
    respond_to do |format|
      if @batch.save
        format.html { redirect_to school_batch_url(@school, @batch), notice: "Batch was successfully created." }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /batches/1 or /batches/1.json
  def update
    authorize @batch
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to school_batch_url(@school, @batch), notice: "Batch was successfully updated." }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1 or /batches/1.json
  def destroy
    authorize @batch
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to school_batches_url(@school), notice: "Batch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find_by(id: params[:school_id])
      redirect_to home_url, notice: 'Invalid School for batches' if @school.blank?
    end

    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params.require(:batch).permit(:school_id, :course_id, :name)
    end
end
