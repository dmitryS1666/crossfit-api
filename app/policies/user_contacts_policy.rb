class UserContactPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true if user.present? && user.superadmin_role?
  end

  def update?
    true if user.present? && user.superadmin_role?
  end

  def destroy?
    true if user.present? && user.superadmin_role?
  end

  private

  def article
    record
  end
end
