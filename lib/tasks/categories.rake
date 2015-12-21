
require_relative '../categories_tasks'

namespace :categories do
  
  desc "take old categories and videos and convergently put them in the new format."
  task :reindex => :environment do
    task_runner = CategoriesTasks.new
    task_runner.reindex
  end

  desc "if slug of a category is empty, create a new one"
  task :regenerate_slugs => :environment do
    task_runner = CategoriesTasks.new
    task_runner.regenerate_slugs
  end

  desc "regenerate short slugs"
  task :regenerate_short_slugs => :environment do
    task_runner = CategoriesTasks.new
    task_runner.regenerate_short_slugs
  end
  
end
