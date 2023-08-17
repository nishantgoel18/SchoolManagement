# frozen_string_literal: true

class SchoolAdminPolicy
  attr_reader :user, :school_admin

  def initialize(user, school_admin)
    @user = user
    @school_admin = school_admin
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
