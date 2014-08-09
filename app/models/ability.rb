class Ability
  include CanCan::Ability

  def initialize(user, organization = nil)
    # super admin
    if !user.nil? && user.admin?
      can :manage, :all
    #organization admin (not yet implemented)

    #organization verified
    elsif !user.nil? && !organization.nil? && organization.verified?(user)
      can :read, :all
      can :create, Project
      can :update, Project do |project|
        project.try(:project_owner) == user
      end
      can :create, ProjectComment

      # Event and project specific models
      can :create, ProjectRating do |rating|
        rating.project.voting_allowed? && !rating.project.voted_on?(user)
      end

      can :create, ProjectVolunteer do |volunteer|
        volunteer.project.volunteering_allowed? && !rating.project.volunteered_for?(user)
      end

      can :create, EventRegistration do |registration|
        registration.event.registration_enabled? && !registration.event.registered?(user)
      end

      can :destroy, ProjectRating do |rating|
        rating.project.voting_allowed? && rating.try(:user) == user
      end

      can :destroy, ProjectVolunteer do |volunteer|
        volunteer.project.volunteering_allowed? && volunteer.try(:user) == user
      end

      can :destroy, EventRegistration do |registration|
        registration.event.registration_enabled? && registration.try(:user) == user
      end

      can :destroy, ProjectComment do |comment|
        comment.try(:user) == user
      end

      # Editing Users
      can :edit, User, :id => user.id
      can :update, User, :id => user.id

    else
      can :read, :all
    end
    #
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
