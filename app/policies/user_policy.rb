class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    admin_list?
  end

  def new?
    record.user == user || admin_list?
  end

  def create?
    record.user == user || admin_list?
  end

  def edit?
    record.user == user || admin_list?
  end

  def update?
    record.user == user || admin_list?
  end

  def destroy?
    admin_list?
  end

  def admin_dashboard?
    admin_list?
  end

  private

  def admin_list?
    !user.nil? && user.admin
  end
end
