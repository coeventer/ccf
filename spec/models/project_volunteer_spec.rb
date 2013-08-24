require 'spec_helper'

describe ProjectVolunteer do
  it "should belong to a project"
  it "should belong to a user"
  it "should notify the project owner when created"
  it "should notify the project owner when destroyed"
  
  it "should be unique between a user and project"
  it "should not be allowed if project does not have an event"
  it "should not be allowed if project event expired" 
end
