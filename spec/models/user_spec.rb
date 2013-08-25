require 'spec_helper'

describe User do
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
