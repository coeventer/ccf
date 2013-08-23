require 'spec_helper'

describe "projects/new" do
  before(:each) do
    assign(:project, stub_model(Project).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", projects_path, "post" do
    end
  end
end
