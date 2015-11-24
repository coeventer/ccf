module ApplicationHelper
  def variable_date_truncate(date)
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql2" then
      "DATE_FORMAT(#{date}, '%m/%d/%Y')"
    else
      "TO_CHAR(#{date}, 'MM/DD/YYYY')"
    end
  end

  # Returns a json object which can be loaded into a Google data table
  def to_json_table(event, collection, date)
    dates_hash = Hash.new
    (event.created_at.to_date..Date.today).map{ |date| date.strftime("%m/%d/%Y") }.each do |d|
      dates_hash[d]=0
    end

    collection.select("count(*) as n, #{variable_date_truncate(date)} as day").
    group(variable_date_truncate(date)).reorder("day").each{|c| dates_hash[c.day]=c.n}

    data_table = [['Date', 'N'].to_s]
    data_table << dates_hash.to_a.collect{|c| c.to_s}

    return data_table.collect{|v| v}.join(",").html_safe
  end

  def facebook_path(event_id = nil)
    return_to = params[:return_to] || request.url
    register_param = (event_id) ? "&register_for_event_id=#{event_id}" : nil
    "#{root_url(subdomain: false)}auth/facebook?origin=#{return_to}#{register_param}"
  end

  def google_oauth2_path(event_id = nil)
    return_to = params[:return_to] || request.url
    register_param = (event_id) ? "&register_for_event_id=#{event_id}" : nil
    "#{root_url(subdomain: false)}auth/google_oauth2?origin=#{return_to}#{register_param}"
  end

  def brand_name
    "<span style='color: #4682B4;'>Co</span><span style='color: #000000;'>Eventer</span>".html_safe
  end

  def comment_delete_path(comment)
    if comment.is_a?(ProjectComment)
      project_project_comment_path(comment.project, comment)
    else
      event_event_comment_path(comment.event, comment)
    end
  end

  def active_event_tab(tab, active)
    tab == active ? "active" : ""
  end

  def check_required(is_checked)
    if is_checked
      '<span class="fa fa-check text-success"></span>'.html_safe
    else
      '<span class="fa fa-times text-danger"></span>'.html_safe
    end
  end

  def check_optional(is_checked)
    if is_checked
      '<span class="fa fa-check text-success"></span>'.html_safe
    else
      '<span class="fa fa-minus text-info"></span>'.html_safe
    end
  end

  def provider_link(provider_user)
    case provider_user.provider
    when 'facebook'
      link_to "https://www.facebook.com/#{provider_user.uid}" do
        "<i class='fa fa-facebook-official'></i> Facebook".html_safe
      end
    when 'google_oauth2'
      link_to "https://plus.google.com/#{provider_user.uid}" do
         "<i class='fa fa-google-plus'></i> Google".html_safe
      end
    else
      provider_user.provider.capitalize
    end
  end
end
