module ApplicationHelper
  def variable_date_truncate(date)
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql2" then
      "DATE_FORMAT(#{date}, '%c/%e/%Y')"
    else
      "TO_CHAR(#{date}, 'MM/DD/YYYY')"
    end
  end

  # Returns a json object which can be loaded into a Google data table
  def to_json_table(collection, date)
    data_table = [['Date', 'N'].to_s]
    data_table << collection.select("count(*) as n, #{variable_date_truncate(date)} as date").
    group(variable_date_truncate(date)).collect{|c| [c.date, c.n].to_s}

    return data_table.collect{|v| v}.join(",").html_safe
  end
end
