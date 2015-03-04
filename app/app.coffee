angular
.module 'email-password', ['ngCookies', 'ngRoute', 'ngMaterial', 'angulartics', 'angulartics.google.analytics']
.config ($routeProvider, $locationProvider, $mdThemingProvider) ->
  $mdThemingProvider.theme('octo-blue')

  $locationProvider.html5Mode 
    enabled: true
    requireBase: false

  $routeProvider
    .when '/',
      templateUrl: '/login.html'
      controller:  'LoginController'
      controllerAs: 'controller'
    .when '/signup',
      templateUrl: '/signup.html'
      controller:  'SignupController'
      controllerAs: 'controller'
    .otherwise redirectTo: '/'
.run ($rootScope, $location) ->
