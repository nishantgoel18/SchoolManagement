# frozen_string_literal: true

class EnrollmentPolicy
  attr_reader :user, :enrollment

  def initialize(user, enrollment)
    @user = user
    @enrollment = enrollment
  end

  def index?
    user.is_admin? or user.is_school_admin? or user.is_student?
  end

  def show?
    true
  end

  def create?
    user.is_admin? or user.is_school_admin? or user.is_student?
  end

  def new?
    user.is_admin? or user.is_school_admin? or user.is_student?
  end

  def update?
    user.is_admin? or user.is_school_admin?
  end

  def edit?
    user.is_admin? or user.is_school_admin?
  end

  def destroy?
    user.is_admin? or user.is_school_admin?
  end
end
