module ViewHelper
  def render_if_exists(args)
    path = args[:partial] || args
    path_parts = path.split('/')
    path_to_view = ['app', 'views'] + path_parts.each_with_index.map do |x, i|
      if (i == path_parts.size - 1)
        "_#{x}.html.erb" # the last item is the file
      else
        x
      end
    end
    if File.exists?(File.join(Rails.root, path_to_view.join(File::SEPARATOR)))
      render args
    end
  end
end
