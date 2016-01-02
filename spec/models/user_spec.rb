require 'spec_helper'

describe User do
  context "projects" do
    it "should have many projects" do
      should have_many(:projects)
    end
    
    it "should have many project comments" do
      should have_many(:project_comments)
    end
    
    it "should have many project ratings" do
      should have_many(:project_ratings)
    end
    
    it "should have many volunteered projects" do
      should have_many(:project_volunteers)
    end  
  end

  context ".create_with_omniauth" do
    let(:auth_with_email) do 
      auth = Hashie::Mash.new
      auth.provider = 'facebook'
      auth.uid = 1
      auth.info!.name = 'Tester'
      auth.info.image = 'http://someaddress.com'
      auth.info.email = 'tester@address.com'
      auth 
    end
    let(:auth_without_email) do
      auth = Hashie::Mash.new
      auth.provider = 'meetup'
      auth.uid = 2
      auth.info!.name = 'Testerer'
      auth.info.image = 'http://someotheraddress.com'
      auth
    end

    it "should create an email_confirmed user if auth includes an email address" do
      user = User.create_with_omniauth(auth_with_email) 
      expect(user.email).to eq auth_with_email.info.email
      expect(user.email_confirmed?).to be true
    end

    it "should create a user with an unconfirmed email if auth does not include an email" do
      user = User.create_with_omniauth(auth_without_email) 
      expect(user.email).to be_nil
      expect(user.email_confirmed?).to be false 
    end
  end

  context "email confirmation" do
    subject{ create(:user) }
    before(:each) do
      @confirmed_users = create_list(:user, 5, email_confirmed: true)
      @unconfirmed_users =  create_list(:user, 5) << subject
    end

    it ".email_confirmation_token should be set" do
      expect(subject.email_confirmation_token).not_to be_nil
      expect(subject.email_confirmation_token).to be_instance_of(String)
    end

    it ".email_confirmed? should be false by default" do
      expect(subject.email_confirmed?).to be false 
    end

    it ".confirm_email should not confirm user with a bad token" do
      subject.confirm_email('badToken')
      expect(subject.email_confirmed?).to be false
    end

    it ".confirm_email should confirm user with a valid token" do
      subject.confirm_email(subject.email_confirmation_token)
      expect(subject.email_confirmed?).to be true
    end

    it "should have an email_confirmed scope" do
      expect(User.email_confirmed.to_set).to eq @confirmed_users.to_set
      expect(@unconfirmed_users.to_set - User.email_confirmed.to_set).to eq @unconfirmed_users.to_set
    end
  end
end
