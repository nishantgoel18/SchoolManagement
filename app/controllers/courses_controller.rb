class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: %i[ show edit update destroy ]

  # GET /courses or /courses.json
  def index
    authorize Course
    @courses = Course.includes(school: :batches)
    @courses = @courses.where(school_id: current_user.school_id) if current_user.is_school_admin?
  end

  # GET /courses/1 or /courses/1.json
  def show
    authorize @course
  end

  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  # GET /courses/1/edit
  def edit
    authorize @course
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)
    authorize @course
    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Course was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: "Course was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    authorize @course
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :school_id)
    end
end
