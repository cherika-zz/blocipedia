class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !record.private? || (user.admin? || user.premium?) || (record.contributors.include?(user))
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user && user.admin?
        scope.all
      elsif user && user.premium?
        # show if it's my wiki or if it's public
        scope.where('user_id = ? OR private = ?', user.id, false)
      elsif user
        # scope.where(private: false || record.users.include?(user))
        scope.eager_load(:collaborators)
        .where("wikis.user_id = ? OR private = ? OR collaborators.user_id = ?", user, false, user)
      else
        scope.none
      end
    end
  end
end

