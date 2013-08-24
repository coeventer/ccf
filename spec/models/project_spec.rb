require 'spec_helper'

describe Project do
  it "should accept votes"
  it "should not accept votes if event voting end date has passed"
  it "should not accept votes if project start date has passed"
  it "should require a title"
  it "should require a description"
  it "should require a project owner"
  it "should associate a github account"
  it "should require a classification"
  it "should accept other classification"
  it "should accept tagging"
  
  it "should be assignable to an event"
  it "should be assignable to a project 'parking lot' if there is no associated event
  "

 it "should have volunteers"
 it "should have comments"
 it "should have ratings"
end
