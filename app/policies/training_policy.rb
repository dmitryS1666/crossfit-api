class TrainingPolicy < ApplicationPolicy
  def index?
    # user.present?
  end

  def show?
    # user.trainer?
  end

  def create?
    # user.present?
  end

  def update?
    # true if user.present?
  end

  def destroy?
    true if user.present? || user.superadmin_role?
  end

  private

  def article
    record
  end
end
