
angular.module('myApp.contacts', ['ui.router']).
    config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
        $stateProvider.state('contacts', {
            abstract: true,
            url: '/contacts',
            templateUrl: 'js/contacts/contacts.html',
            resolve: {
                contacts: ['contacts', function(contacts) {
                    return contacts.all();
                }]
            },
            controller: [        '$scope', '$state', 'contacts', 'utils',
                         function($scope,   $state,   contacts,   utils) {
                             $scope.contacts = contacts;
                         }]
        }).
        state('contacts.list', {
            url: '',
            templateUrl: 'js/contacts/contacts.list.html'
        }).
        state('contacts.detail', {
            url: '/{contactId:[0-9]{1,4}}',
            views: {
                '': {
                    templateUrl: 'js/contacts/contacts.detail.html',
                    controller: [        '$scope', '$stateParams', 'utils',
                                 function($Scope,   $stateParams,   utils) {
                                     $scope.contact = utils.findById($scope.contacts, $stateParams.contactId);
                                 }]
                },
                'hint@': {
                    template: 'This is contacts.detail populating the hint.'
                },
                'menuTip': {
                    template: 'this is menu tip apparently.'
                }
            }
        });
    }]);