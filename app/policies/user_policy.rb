class UserPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    true if user.present?
  end

  def all_users?
    true if user.present?
  end

  def destroy?
    true if user.present?
  end

  private

  def article
    record
  end
end
