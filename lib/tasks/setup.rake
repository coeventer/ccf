desc "Set up application from fresh checkout"
task :setup => ["setup:setup"]
namespace :setup do
  task :setup do
    Rake::Task['setup:configs'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end
  
  desc "Copy example config files"
  task :configs do
    file_pattern = File.join(File.expand_path("../../..", __FILE__), "config", "*.yml.example")
    Dir.glob(file_pattern).each do |example_path|
      config_path = example_path.gsub(".example", "")
      unless File.exist? config_path
        FileUtils.cp example_path, config_path
        puts "copied #{config_path}"
      end
    end
  end
end
