require 'spec_helper'

describe SessionsController, type: :controller do
  context "create" do
    let(:auth_with_email) do 
      auth = Hashie::Mash.new
      auth.provider = 'facebook'
      auth.uid = 1
      auth.info!.name = 'Tester'
      auth.info.image = 'http://someaddress.com'
      auth.info.email = 'tester@address.com'
      auth.credentials!.token = '1234'
      auth 
    end
    let(:auth_without_email) do
      auth = Hashie::Mash.new
      auth.provider = 'meetup'
      auth.uid = 2
      auth.info!.name = 'Testerer'
      auth.info.image = 'http://someotheraddress.com'
      auth.credentials!.token = '1234'
      auth
    end
    let(:auth_developer) do
      auth = Hashie::Mash.new
      auth.provider = 'developer'
      auth.uid = 2
      auth.info!.name = 'Tester'
      auth.info.email = 'tester@address.com'
      auth.credentials!.token = '1234'
      auth
    end
    before(:each) do
      @request.env['omniauth.params'] = {'register_for_event_id' => nil}
      @request.env['omniauth.origin'] = nil
    end

    it "should redirect to an email address prompt if OAuth does not provide an email address" do
      @request.env["omniauth.auth"] = auth_without_email
      post :create
      expect(response).to redirect_to set_email_users_path
    end

    it "should not redirect to an email address prompt if OAuth does provide an email address" do
      @request.env["omniauth.auth"] = auth_with_email
      post :create
      expect(response).to redirect_to root_url 
    end

    it "should log in a developer" do
      @request.env["omniauth.auth"] = auth_developer
      post :create
      expect(response).to redirect_to root_url
      user = User.find_by_id!(session[:user_id])
      expect(user.email).to eq("tester@address.com")
    end
  end
end
