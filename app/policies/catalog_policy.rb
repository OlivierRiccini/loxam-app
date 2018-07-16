class CatalogPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    admin_list?
  end

  private

  def admin_list?
    !user.nil? && user.admin
  end
end
