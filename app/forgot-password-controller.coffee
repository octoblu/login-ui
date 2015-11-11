class ForgotPasswordController
  constructor: (AuthenticatorService, $routeParams) ->
    @AuthenticatorService = AuthenticatorService
    @callbackUrl = $routeParams.callback ? 'https://app.octoblu.com/api/session'
    @loginPath = "/?" + $.param(callback: @callbackUrl)

  forgotPassword: (email) =>
    delete @message
    delete @errorMessage
    @AuthenticatorService.forgotPassword(email)
      .then =>
        @message = 'An email has been sent.'
      .catch =>
        @errorMessage = 'Error resetting your password'

angular.module('email-password').controller 'ForgotPasswordController', ForgotPasswordController
