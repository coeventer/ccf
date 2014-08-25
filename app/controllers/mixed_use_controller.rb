class MixedUseController < ApplicationController
  include OrganizationLib
  layout :determine_layout

  def determine_layout
    if current_organization.nil?
      'application'
    else
      'organization'
    end
  end
end