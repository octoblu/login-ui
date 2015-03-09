class LoginController
  constructor: ($routeParams, $window, AuthenticatorService) ->
    @routeParams = $routeParams
    @window = $window
    @AuthenticatorService = AuthenticatorService

  emailRequiredError: =>
    return true if @loginForm.email.$error.required && @loginForm.email.$touched
    return true if @loginForm.$submitted && !@loginForm.email

  passwordRequiredError: =>
    return true if @loginForm.password.$error.required && @loginForm.password.$touched
    return true if @loginForm.$submitted

  login: (email, password) =>
    @loginForm.email.$setTouched()
    @loginForm.password.$setTouched()
    return unless @loginForm.$valid

    callbackUrl = @routeParams.callback ? 'https://app.octoblu.com/api/session'

    @loading = true
    @AuthenticatorService
      .authenticate email, password, callbackUrl
      .then (location) =>
        @window.location = location
      .catch (error) =>
        @loading = false
        @errorMessage = error

angular.module('email-password').controller 'LoginController', LoginController
