class LoginController
  constructor: (AuthenticatorService) ->
    @AuthenticatorService = AuthenticatorService

  login: (email, password) =>
    @AuthenticatorService
      .authenticate email, password
      .catch (error) =>
        @errorMessage = error

angular.module('email-password').controller 'LoginController', LoginController
