class SchoolAdminsController < ApplicationController
  before_action :authenticate_user!
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

  # GET /school_admins/new
  def new
    @school_admin = SchoolAdmin.new
    authorize @school_admin
  end

  # GET /school_admins/1/edit
  def edit
    authorize @school_admin
  end

  # POST /school_admins or /school_admins.json
  def create
    @school_admin = SchoolAdmin.new(school_admin_params)
    authorize @school_admin
    respond_to do |format|
      if @school_admin.save
        format.html { redirect_to school_admin_url(@school_admin), notice: "SchoolAdmin was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /school_admins/1 or /school_admins/1.json
  def update
    authorize @school_admin
    respond_to do |format|
      if @school_admin.update(school_admin_params)
        format.html { redirect_to school_admin_url(@school_admin), notice: "SchoolAdmin was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /school_admins/1 or /school_admins/1.json
  def destroy
    authorize @school_admin
    @school_admin.destroy

    respond_to do |format|
      format.html { redirect_to school_admins_url, notice: "SchoolAdmin was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_admin
      @school_admin = SchoolAdmin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def school_admin_params
      params.require(:school_admin).permit(:name, :email, :password, :school_id)
    end
end
