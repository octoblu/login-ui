class LoginController
  constructor: (AuthenticatorService) ->
    @AuthenticatorService = AuthenticatorService

  login: (email, password) =>
    @AuthenticatorService
      .authenticate email, password
      .then (error) =>
        @errorMessage = error

angular.module('email-password').controller 'LoginController', LoginController
