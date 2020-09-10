class UserContactPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true if user.present?
  end

  def update?
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
