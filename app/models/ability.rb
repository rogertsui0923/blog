class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin
      can :manage, :all
    end

    can :manage, Post do |post|
      post.user == user
    end

    can :manage, Comment do |comment|
      comment.user == user || comment.post.user == user
    end

    can :manage, User do |u|
      u == user
    end
  end
end
