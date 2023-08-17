# frozen_string_literal: true

class BatchPolicy
  attr_reader :user, :batch

  def initialize(user, batch)
    @user = user
    @batch = batch
  end

  def index?
    user.is_admin? or user.is_school_admin?
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
