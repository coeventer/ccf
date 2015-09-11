class Ability
  include CanCan::Ability

  def initialize(user, organization = nil)
    if user.nil?
      can :read, :all
    # super admin
    elsif user.admin?
      can :manage, :all
    #organization admin (not yet implemented)
    elsif !organization.nil? && organization.admin?(user)
      can :manage, :all, organization_id: organization.id
    #organization verified
    elsif !organization.nil? && organization.verified?(user)
      can :read, :all
      # Editing Users
      can_edit_user(user)

      # Any verified user
      can :create, Project
      can :update, Project do |project|
        project.try(:project_owner) == user || (!project.event.nil? && project.event.moderator?(user))
      end
      can :create, ProjectComment
      can :create, ProjectRating do |rating|
        rating.project.voting_allowed? && !rating.project.voted_on?(user)
      end

      can :create, ProjectVolunteer do |volunteer|
        volunteer.project.volunteering_allowed? && !rating.project.volunteered_for?(user)
      end

      can :create, EventRegistration do |registration|
        registration.event.registration_enabled? && !registration.event.registered?(user)
      end

      can :create, EventComment

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
        comment.try(:user) == user || (!comment.project.event.nil? && comment.project.event.moderator?(user))
      end

      can :destroy, EventComment do |comment|
        comment.try(:user) == user || comment.event.moderator?(user)
      end

      can :edit, Presentation do |presentation|
        presentation.project.try(:project_owner) == user || (!presentation.project.event.nil? && presentation.project.event.moderator?(user))
      end

    else
      can :read, :all
      can_edit_user(user)
    end
  end

  def can_edit_user(user)
    can :edit, User, :id => user.id
    can :update, User, :id => user.id
  end
end
