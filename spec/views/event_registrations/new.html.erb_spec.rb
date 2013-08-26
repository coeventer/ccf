require 'spec_helper'

describe "event_registrations/new" do
  before(:each) do
    assign(:event_registration, stub_model(EventRegistration).as_new_record)
  end

  it "renders new event_registration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_registrations_path, "post" do
    end
  end
end
