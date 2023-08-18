class SchoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_school, only: %i[ show edit update destroy ]

  # GET /schools or /schools.json
  def index
    authorize School 
    @schools = School.includes(:courses, :batches, :school_admins)
    @schools = @schools.where(id: current_user.school_id) if !current_user.is_admin?
  end

  # GET /schools/1 or /schools/1.json
  def show
    authorize @school
  end

  # GET /schools/new
  def new
    @school = School.new
    authorize @school
  end

  # GET /schools/1/edit
  def edit
    authorize @school
  end

  # POST /schools or /schools.json
  def create
    @school = School.new(school_params)
    authorize @school
    respond_to do |format|
      if @school.save
        format.html { redirect_to school_url(@school), notice: "School was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1 or /schools/1.json
  def update
    authorize @school
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to school_url(@school), notice: "School was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1 or /schools/1.json
  def destroy
    authorize @school
    @school.destroy

    respond_to do |format|
      format.html { redirect_to schools_url, notice: "School was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def school_params
      params.require(:school).permit(:name, :address, :about)
    end
end
