class LoginController
  constructor: ($routeParams, $window, AuthenticatorService) ->
    @routeParams = $routeParams
    @window = $window
    @AuthenticatorService = AuthenticatorService
    @callbackUrl = @routeParams.callback ? 'https://app.octoblu.com/api/session'
    @signupPath = "/signup?" + $.param(callback: @callbackUrl)

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

    @loading = true
    @AuthenticatorService
      .authenticate email, password, @callbackUrl
      .then (location) =>
        @window.location = location
      .catch (error) =>
        @loading = false
        @errorMessage = 'That email/password combination does not match our records'

angular.module('email-password').controller 'LoginController', LoginController
