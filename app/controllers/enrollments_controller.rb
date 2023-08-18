class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school
  before_action :set_enrollment, only: %i[ show edit update destroy ]

  # GET /enrollments or /enrollments.json
  def index
    authorize Enrollment
    @enrollments = Enrollment.includes(:batch, :student)
    @enrollments = @enrollments.where(batch_id: @school.batches)
    @enrollments = @enrollments.where(user_id: current_user.id) if current_user.is_student?
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
    authorize @enrollment
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
    authorize @enrollment
  end

  # GET /enrollments/1/edit
  def edit
    authorize @enrollment
  end

  # POST /enrollments or /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)
    authorize @enrollment
    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to school_enrollment_url(@school, @enrollment), notice: "Enrollment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    authorize @enrollment
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to school_enrollment_url(@school, @enrollment), notice: "Enrollment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    authorize @enrollment
    @enrollment.destroy

    respond_to do |format|
      format.html { redirect_to school_enrollments_url(@school), notice: "Enrollment was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find_by(id: params[:school_id])
      redirect_to home_url, notice: 'Invalid School for enrollments' if @school.blank?
    end

    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:batch_id, :user_id, :status)
    end
end
