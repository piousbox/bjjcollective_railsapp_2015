
set :deploy_to, "/home/ubuntu/projects/bjjcollective"
set :app_user, "ubuntu"

server 'app_81', :user => 'ubuntu', :roles => [ :web ], :primary => true

