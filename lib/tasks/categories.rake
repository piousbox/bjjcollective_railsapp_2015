
require_relative '../categories_tasks'

namespace :categories do
  
  desc "take old categories and videos and convergently put them in the new format. This is obsolete since using mongo store."
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

  desc 'all categories with path == id, convert to path that makes sense. 20170724'
  task :convert_path_20170724 => :environment do
    categories = Hash.new
    Category.all.map do |c|
      if c.path.to_s == c.id.to_s
        categories[c.id] = c.id
      end
    end
    puts! categories.count, "this many categories to process"

    categories.each do |c1, c2|
      c = Category.find c1
      c.path = c.category.path + "/" + c.short_slug
      flag = c.save
      if !flag
        puts! c.errors.messages
      end
    end

    categories = Hash.new
    Category.all.map do |c|
      if c.path.to_s == c.id.to_s
        categories[c.id] = c.id
      end
    end
    puts! categories.count, "this many categories to process"
  end

  desc 'init Technique category'
  task :init_technique => :environment do
    technique = Category.find_or_create_by :title => 'Technique', :slug => 'technique', :short_slug => 'technique', :path => '/'
    orphan_categories = Category.where( :category_id => nil )
    if orphan_categories.count > 0
      orphan_categories.update_all :category_id => technique
    end
  end

end
