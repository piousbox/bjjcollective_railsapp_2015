
About
=====

The fighers guild!

http://bjjcollective.com

Check out the branches! This is a branched repo.

Development
===========

Port 3001 please
bjjc.local runs on port 81
bjjc-angular.local is required to run

@TODO: There needs to be disaster recovery
@TODO: Show of a merit badge should have human url
@TODO: Video2 is video. video is video_legacy
@TODO: Video link should be human-readable
@TODO: I should not be able to create a video linked to both a badge and a questset. (polymorphism)
@TODO: All questsets are shaded, and once you accomplish a questset, the pic changes, and the next one opens up
@TODO: Be able to delete questsets
@TODO: Better s3 creds for BJJC

Deployment
==========

Hit these three URLs to generate the cache (each takes a few minutes):
* http://staging.bjjcollective.piousbox.com/
* http://staging.bjjcollective.piousbox.com/videos/5674a60f2dd1095edb0004de
* http://staging.bjjcollective.piousbox.com/categories/view/mounts-side-control-side-control-variants-twister-over-arm-top-submissions

* Don't forget to enable sites and restart apache2!



CI/CD Pipeline
==============

 sudo apt-get install libmysqlclient-dev -y
 sudo apt-get install mysql-client-core-5.6 -y



Change Log
==========
* 20151122 .htaccess on manager
* 20151203 tasks from the first email
* 20151219 - 0.0.1 - Manager video pagination
* 0.0.2 - structure for categories
* 0.0.3 - caching
* 0.0.4 - leaderboards
* 0.0.5 - legacy video redirect
* 0.0.6 - let's go angular
* 0.0.7 - angular is out, let's put angular in.