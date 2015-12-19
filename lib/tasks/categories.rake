
require_relative '../categories_tasks'

namespace :categories do
  
  desc "take old categories and videos and convergently put them in the new format."
  task :reindex => :environment do
    CategoriesTasks.sanity
  end

end
