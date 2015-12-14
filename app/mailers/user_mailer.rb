class UserMailer < ActionMailer::Base
  include ApplicationHelper
  default :from => "no-reply@#{APP_CONFIG['mail']['domain']}"
  def user_created(user)
    @user = user
    @brand = brand_name
    mail = mail(:to => @user.email, :subject => "Your account has been created for #{APP_CONFIG['brand']['site_name']}") do |format|
      format.html
    end

    mail
  end

  def user_verified(user, organization)
    @user = user
    @organization = organization
    @brand = brand_name
    @future_events = Event.live.where(["end_date >= ?", Date.today])
    mail = mail(:to => @user.email, :subject => "Your account has been verified for #{organization.name}") do |format|
      format.html
    end

    mail
  end

  def organization_user_created(user, organization)
    @user = user
    @organization = organization
    @brand = brand_name
    @future_events = Event.live.where(["end_date >= ?", Date.today])
    mail = mail(:to => @user.email, :subject => "Welcome to #{organization.name}, a part of #{APP_CONFIG['brand']['site_name']}") do |format|
      format.html
    end

    mail
  end

  def event_moderator(user, event)
    @user = user
    @event = event
    @brand = brand_name
    mail = mail(:to => @user.email, :subject => "You have been selected as a moderator for #{@event.name}") do |format|
      format.html
    end

    mail
  end

  def confirm_email(user)
    @user = user
    @brand = brand_name
    mail = mail(to: user.email, subject: "Email Confirmation from #{APP_CONFIG['brand']['site_name']}") do |format|
      format.html
    end

    mail.deliver
  end
end
