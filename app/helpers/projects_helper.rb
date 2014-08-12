module ProjectsHelper
  def sort_path(sort_param , event=nil)
    event.nil? ? projects_path(sort: sort_param) : event_path(event, sort: sort_param)
  end
end
