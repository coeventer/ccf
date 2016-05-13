namespace :hotness do

  desc "Get the new hotness"
  task :calculate do
    Event.unscoped.where("end_date >= ?", Time.now).each do |event|
      event.projects.each(&:recalculate_hotness)
    end

  end
end
