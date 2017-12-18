class Ability
  include CanCan::Ability

  def initialize(user)
    #
    # manager
    #
    if true || user.group_id == 1 # not used
      can [ :manage ], Task
      can [ :manage ], Video
    end

    #
    # guest user (not logged in)
    #
    user ||= User.new 
    
    can [ :home, :about, :donate, :fb_sign_in, :buy_stars ], Ability

    can [ :show, :buy ], MeritBadge
    can [ :show, :index ], Questpage
    can [ :show ], Questset
    can [ :show ], Video

    can [ :update ], PlayerVideo do |player_video|
      player_video.user_id == user.id
    end
    
    can [ :shallow_index ], Category

    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
