require "spec_helper"

describe EventRegistrationsController do
  describe "routing" do

    it "routes to #index" do
      get("/event_registrations").should route_to("event_registrations#index")
    end

    it "routes to #new" do
      get("/event_registrations/new").should route_to("event_registrations#new")
    end

    it "routes to #show" do
      get("/event_registrations/1").should route_to("event_registrations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/event_registrations/1/edit").should route_to("event_registrations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/event_registrations").should route_to("event_registrations#create")
    end

    it "routes to #update" do
      put("/event_registrations/1").should route_to("event_registrations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/event_registrations/1").should route_to("event_registrations#destroy", :id => "1")
    end

  end
end
