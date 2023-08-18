class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    authorize Student
    @students = Student.includes(:batches, :courses)
    @students = @students.where(school_id: current_user.school_id) if !current_user.is_admin?
  end

  # GET /students/1 or /students/1.json
  def show
    authorize @student
  end

  # GET /students/new
  def new
    @student = Student.new
    authorize @student
  end

  # GET /students/1/edit
  def edit
    authorize @student
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    authorize @student
    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    authorize @student
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    authorize @student
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :email, :password, :school_id)
    end
end
