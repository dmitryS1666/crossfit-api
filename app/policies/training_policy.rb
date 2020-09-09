class TrainingPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.trainer?
  end

  def update?
    user.trainer?
  end

  def destroy?
    true if user.present? || user.superadmin_role?
  end

  private

  def article
    record
  end
end
