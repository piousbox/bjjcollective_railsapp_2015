// Karma configuration
// Generated on Wed Dec 30 2015 17:19:14 GMT-0800 (PST)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine'],


    // list of files / patterns to load in the browser
    files: [
      'public_angular/lib/modernizr.js',
      'public_angular/lib/jquery/jquery.js',
      'public_angular/lib/foundation/foundation.js',
      'public_angular/lib/lodash.js',

      'public_angular/lib/angular/angular.js',
      'public_angular/lib/angular/angular-route.js',
      'public_angular/lib/angular/angular-resource.js',
      'public_angular/lib/angular/angular-animate.js',
      'public_angular/lib/angular/angular-ui-router.js',
      'public_angular/lib/angular/angular-sanitize.js',

      'public_angular/lib/angulartics.min.js',
      'public_angular/lib/angulartics-google-analytics.min.js',

      'test/lib/angular/angular-mocks.js',

      'public_angular/js/app.js',
      'public_angular/js/config.js',
      'public_angular/js/controllers/categories.js',
      'public_angular/js/controllers/categories_controllers.js',
      'public_angular/js/services/services.js',
      'public_angular/js/services/categories-service.js',

      'test-angular/unit/categoriesSpec.js'
    ],


    // list of files to exclude
    exclude: [
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
    },


    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    // reporters: ['progress'],
    reporters: ['dots', 'junit'], // _vp_ 20151230


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS'], // _vp_ 20151230 ['Chrome'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: true, // _vp_ 20151230

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity
  })
}