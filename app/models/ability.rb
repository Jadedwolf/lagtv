class Ability
  include CanCan::Ability

  def initialize(current_user)
    # can :read, Forem::Category
    # can :read, Forem::Topic
    # can :read, Forem::Forum

    if current_user
      # can :create_topic, Forem::Forum
      # can :reply, Forem::Topic

      if current_user.admin?
        # admin permissions
        can :manage, :all
      elsif current_user.community_manager?
        # community manager permissions
        can :manage, User
        can :manage, Replay
        can :manage, Comment
        cannot :change_role, User
        # can :edit_post, Forem::Forum
        # can :moderate, Forem::Forum
      elsif current_user.member?
        # member permissions
        can :edit, User do | user |
          user == current_user
        end
        can :create, Replay do |replay|
          replay.user == current_user
        end
      end
    end
  end
end