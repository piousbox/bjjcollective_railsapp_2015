lock "3.10.1"

set :application, "bjjc_api"
set :repo_url, "git@github.com:piousbox/bjjcollective_railsapp_2015.git"

append :linked_files, "config/initializers/00_s3.rb", "config/mongoid.yml", "config/database.yml", "config/initializers/devise.rb", "config/koala.yml", "config/initializers/stripe.rb"

set :deploy_via, :remote_cache

namespace :deploy do
  task :bundle do
    on roles(:web) do
      execute "cd /home/#{fetch(:app_user)}/projects/bjjcollective/current && sudo /home/#{fetch(:app_user)}/.rbenv/versions/2.3.1/bin/bundle --path /home/#{fetch(:app_user)}/projects/bjjcollective/vendor/bundle"
    end
  end

  task :migrate do
    on roles(:web) do
      execute "cd /home/#{fetch(:app_user)}/projects/bjjcollective/current && sudo /home/#{fetch(:app_user)}/.rbenv/versions/2.3.1/bin/bundle exec rake migrate"
    end
  end

  task :restart_nginx do
    on roles(:web) do
      execute "sudo systemctl restart nginx.service"
    end
  end
end

after "deploy:published", "restart_nginx"
after "deploy:published", "bundle"
after "deploy:published", "migrate"
after "deploy:published", "restart_nginx"

