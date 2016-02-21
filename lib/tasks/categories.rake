
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

  desc "clear short slugs"
  task :clear_short_slugs => :environment do
    CategoriesTasks.new.clear_short_slugs
  end

  desc "assign kind - @obsolete, use normalize_kind_and_path. 20160220"
  task :assign_kind => :environment do
    CategoriesTasks.new.assign_kind
  end

  desc "normalize kind and path"
  task :normalize_kind_and_path => :environment do
    CategoriesTasks.new.normalize_kind_and_path
  end
  
end
