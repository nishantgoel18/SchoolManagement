# frozen_string_literal: true

class CoursePolicy
  attr_reader :user, :course

  def initialize(user, course)
    @user = user
    @course = course
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.is_admin? or user.is_school_admin?
  end

  def new?
    user.is_admin? or user.is_school_admin?
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
