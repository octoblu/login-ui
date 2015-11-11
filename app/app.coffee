angular
.module 'email-password', ['ngCookies', 'ngRoute', 'ngMaterial', 'angulartics', 'angulartics.google.analytics']
.config ($routeProvider, $locationProvider, $mdThemingProvider) ->
  $mdThemingProvider.theme('octo-blue')

  html5Options = enabled: true, requireBase: false
  $locationProvider.html5Mode(html5Options).hashPrefix '!'

  $routeProvider
    .when '/',
      templateUrl: '/pages/login.html'
      controller:  'LoginController'
      controllerAs: 'controller'
    .when '/signup',
      templateUrl: '/pages/signup.html'
      controller:  'SignupController'
      controllerAs: 'controller'
    .when '/forgot',
      templateUrl: '/pages/forgot-password.html'
      controller:  'ForgotPasswordController'
      controllerAs: 'controller'
    .when '/reset',
      templateUrl: '/pages/reset-password.html'
      controller:  'ResetPasswordController'
      controllerAs: 'controller'
    .otherwise redirectTo: '/'
.run ($rootScope, $location) ->
