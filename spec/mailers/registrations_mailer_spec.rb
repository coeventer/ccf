require 'spec_helper'
 
RSpec.describe RegistrationMailer do
  describe 'instructions' do
    let(:organization) { create :organization }
    let(:event) { create :event, organization: organization }
    let(:user)  { create :user, email: "test@test.com" }
    let(:event_registration) { create :event_registration, user: user, event: event }
    let(:mail) { RegistrationMailer.registration_created(event_registration) }
 
    it 'renders the subject' do
      expect(mail.subject).to eq "Registered For \"#{event.title}\""
    end
 
    it 'renders the receiver email' do
      expect(mail.to).to eq [user.email]
    end
 
    it 'renders the sender email' do
      expect(mail.from).to eq "no-reply@#{APP_CONFIG['mail']['domain']}"
    end
 
    it 'assigns @name' do
      expect(mail.body.encoded).to match(user.name)
    end


    it 'contains the registration body' do
      expect(mail.body.encoded).to match('You have successfully registered for')
    end
  end
end
