class UserPolicy < ApplicationPolicy
  attr_reader :user_info, :user

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(user_info, user)
    @user_info = user_info
    @user = user
  end

  def index?
    user_info.id == 1
  end

  def update?
    user_info.id == 1 or not user.published?
  end
end
