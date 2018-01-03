
# require_relative '../videos_tasks'

task :migrate => [
  'db:mongoid:create_indexes',
  'migrate:questpages_trash_and_active'
]

namespace :migrate do

  desc 'define for all questpages: is_trash and is_active'
  task :questpages_trash_and_active => :environment do
    Questpage.where( :is_trash => nil ).update_all( :is_trash => false )
    Questpage.where( :is_active => nil ).update_all( :is_active => true )
    puts 'OK questpages trash and active'
  end

=begin  
  desc "Look at all the VideoLegacy and record its id as legacy_id of the corresponding Video."
  task :churn_legacy_id => :environment do
    task_runner = VideosTasks.new
    task_runner.churn_legacy_id
  end
=end

end
