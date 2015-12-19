
require_relative '../categories_tasks'

namespace :categories do
  
  desc "take old categories and videos and convergently put them in the new format."
  task :reindex => :environment do
    task_runner = CategoriesTasks.new
    task_runner.reindex
  end

end
