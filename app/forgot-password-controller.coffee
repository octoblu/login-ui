class ForgotPasswordController
  constructor: (AuthenticatorService) ->
    @AuthenticatorService = AuthenticatorService

  forgotPassword: (email) =>
    @AuthenticatorService.forgotPassword(email)
      .then =>
        @message = 'An email has been sent.'
      .catch =>
        @errorMessage = 'Error resetting your password'

angular.module('email-password').controller 'ForgotPasswordController', ForgotPasswordController
