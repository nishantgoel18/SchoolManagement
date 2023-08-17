# frozen_string_literal: true

class SchoolPolicy
  attr_reader :user, :school

  def initialize(user, school)
    @user = user
    @school = school
  end

  def index?
    user.is_admin? or user.is_school_admin? or user.is_student?
  end

  def show?
    true
  end

  def create?
    user.is_admin?
  end

  def new?
    user.is_admin?
  end

  def update?
    user.is_admin? or user.is_school_admin?
  end

  def edit?
    user.is_admin? or user.is_school_admin?
  end

  def destroy?
    user.is_admin?
  end
end
