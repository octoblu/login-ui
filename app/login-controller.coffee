class LoginController
  constructor: ($routeParams, AuthenticatorService) ->
    @AuthenticatorService = AuthenticatorService
    @routeParams = $routeParams

  emailRequiredError: =>
    return true if @loginForm.email.$error.required && @loginForm.email.$touched
    return true if @loginForm.$submitted

  passwordRequiredError: =>
    return true if @loginForm.password.$error.required && @loginForm.password.$touched
    return true if @loginForm.$submitted

  login: (email, password) =>
    @loginForm.email.$setTouched()
    @loginForm.password.$setTouched()
    return unless @loginForm.$valid

    @loading = true
    @AuthenticatorService
      .authenticate email, password, @routeParams.callback
      .then (error) =>
        @loading = false
        @errorMessage = error

angular.module('email-password').controller 'LoginController', LoginController
