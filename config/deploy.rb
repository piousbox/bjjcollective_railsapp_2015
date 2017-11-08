lock "3.10.0"

set :application, "bjjcapi"
set :repo_url, "git@github.com:piousbox/bjjcollective_railsapp_2015.git"

append :linked_files, "config/initializers/00_s3.rb", "config/mongoid.yml", "config/database.yml", "config/initializers/devise.rb"
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
# set :linked_files, %w( config/initializers/00_s3.rb config/mongoid.yml )

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :deploy_via, :remote_cache

namespace :deploy do
  task :bundle do
    on roles(:web) do
      execute "cd #{fetch(:deploy_to)}/current && sudo /home/#{fetch(:app_user)}/.rbenv/versions/2.3.1/bin/bundle --path #{fetch(:deploy_to)}/vendor/bundle"
    end
  end

  task :restart_nginx do
    on roles(:web) do
      execute "sudo systemctl restart nginx.service"
    end
  end
end

after "deploy:published", "bundle"
after "deploy:published", "restart_nginx"

