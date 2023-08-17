# frozen_string_literal: true

class StudentPolicy
  attr_reader :user, :student

  def initialize(user, student)
    @user = user
    @student = student
  end

  def index?
    true
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
    user.is_admin?
  end

  def edit?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end
end
