
About
=====

Well, there is the fighters guild,
then there is the shop,
then there is the legacy site,
then there is the manager,

then there is the v2 of categories (encyclopedia). 
I want it in both react and rails views.

-=----- instructions on how to set it up
* get the code
* install mongodb
* setup s3
* get some test data
* run tests

Install
=======
 sudo apt-get install libmysqlclient-dev -y
 sudo apt-get install mysql-client-core-5.6 -y
 https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-14-04
 https://ubuntu.flowconsult.at/en/mysql-set-change-reset-root-password/

Development
===========
* ror app, port 3001
* bjjc.local:80 (virtual site)
** /technique -> bjjc-angular.local:80
* bjjc-angular.local (virtual site)
** /api -> bjjc.local:80/api

 be rake db:mongoid:create_indexes

TODO
====
@TODO: Show of a merit badge should have human url
@TODO: Video2 is video. video is video_legacy
@TODO: Video link should be human-readable
@TODO: I should not be able to create a video linked to both a badge and a questset. (polymorphism)
@TODO: All questsets are shaded, and once you accomplish a questset, the pic changes, and the next one opens up
@TODO: Be able to delete questsets

Deployment
==========

Hit these three URLs to generate the cache (each takes a few minutes):
* http://staging.bjjcollective.piousbox.com/
* http://staging.bjjcollective.piousbox.com/videos/5674a60f2dd1095edb0004de
* http://staging.bjjcollective.piousbox.com/categories/view/mounts-side-control-side-control-variants-twister-over-arm-top-submissions

* Don't forget to enable sites and restart apache2!

 mysql root:awesome_passw0rd

 RAILS_ENV=production ~/.rbenv/versions/2.3.1/bin/bundle exec rails c
 be cap vm deploy
 be cap aws_staging deploy

Package
=======
* Merge the latest x.x.x branch to master and precompile assets.


CI/CD Pipeline
==============

 sudo apt-get install libmysqlclient-dev -y
 sudo apt-get install mysql-client-core-5.6 -y

port 3001



