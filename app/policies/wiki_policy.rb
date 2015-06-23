class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !record.private? || (user.admin? || user.premium?) 
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
        scope.where(private: false || nil)
      end
    end
  end
end
