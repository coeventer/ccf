class UserMailer < ActionMailer::Base
  include ApplicationHelper
  default :from => "no-reply@#{APP_CONFIG["domain"]}"
  def user_created(user)
    @user = user
    @brand = brand_name
    mail = mail(:to => @user.email, :subject => "Your account has been created for #{@brand}") do |format|
      format.html
    end

    mail.deliver
  end

  def user_verified(user, organization)
    @user = user
    @organization = organization
    @brand = brand_name
    @future_events = Event.live.where(["end_date >= ?", Date.today])
    mail = mail(:to => @user.email, :subject => "Your account has been verified for #{organization.name}") do |format|
      format.html
    end

    mail.deliver
  end

  def organization_user_created(user, organization)
    @user = user
    @organization = organization
    @brand = brand_name
    @future_events = Event.live.where(["end_date >= ?", Date.today])
    mail = mail(:to => @user.email, :subject => "Welcome to #{organization.name}, a part of #{brand_name}") do |format|
      format.html
    end

    mail.deliver
  end

  def event_moderator(user, event)
    @user = user
    @event = event
    @brand = brand_name
    mail = mail(:to => @user.email, :subject => "You have been selected as a moderator for #{@event.name}") do |format|
      format.html
    end

    mail.deliver
  end
end
