class AnswerPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    if user
      user.admin? || record.try(:author) == user
    end
  end

  def destroy?
    user.admin? if user
  end
end