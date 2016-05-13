namespace :hotness do

  desc "Get the new hotness"
  task :calculate => :environment do
    Event.unscoped.where("end_date >= ?", Time.now).each do |event|
      Project.unscoped.where(event_id: event.id).each(&:recalculate_hotness)
    end
  end
end
