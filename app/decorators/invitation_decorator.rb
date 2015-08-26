class InvitationDecorator < Draper::Decorator
  delegate_all
  delegate :current_page, :total_entries, :total_pages, :per_page, :offset

  def title
    "Invitation to #{context_type}: #{object.name}"
  end

  def description
    if event?
      %{
      #{object.name} will take place #{object.invited_resource.pretty_dates}. Accepting this invitation will 
      register you for this event.
      }
    else
      %{
      You have been invited to join the organization #{object.name}. If you accept, you will become a verified member
      of the organization.
      }
    end
  end

  def to
    object.email || user.name
  end

  def email
    object.email || user.email
  end

end
