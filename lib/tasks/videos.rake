
require_relative '../videos_tasks'

namespace :videos do
  
  desc "Look at all the VideoLegacy and record its id as legacy_id of the corresponding Video."
  task :churn_legacy_id => :environment do
    task_runner = VideosTasks.new
    task_runner.churn_legacy_id
  end

end
