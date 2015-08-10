require 'active_support/concern'
require 'slack-notifier'

module SlackNotifiable
  extend ActiveSupport::Concern
  
  included do
    after_create :ping_slack
  end

  def ping_slack
    return unless Rails.env.production? && respond_to?(:organization) && organization.slack_webhook_url

    begin
      Slack::Notifier.new(organization.slack_webhook_url, username: 'Notifier').ping(slack_message)
    rescue Exception => e
      # non-essential so do nothing
    end
  end

  def slack_message
    self.inspect
  end

end
