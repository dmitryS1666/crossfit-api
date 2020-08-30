class UserPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    # true if user.present? && (user.email == article.email || user.superadmin_role?)
    true if user.present?
  end

  def all_users?
    true if user.present? && user.superadmin_role?
  end

  def destroy?
    true if user.present? && (user.email == article.email || user.superadmin_role?)
  end

  private

  def article
    record
  end
end
