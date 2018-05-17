class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    admin_list?
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    admin_list?
  end

  private

  def admin_list?
    !user.nil? && user.admin
  end
end
