class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !record.private? || (user.present? && ((user.role == 'admin') || record.user == user || record.users.include?(user))) 
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user && (user.admin? || user.premium?)
        scope.all
      elsif user
        scope.where(private: false || private: nil)
      end
    end
  end
end
