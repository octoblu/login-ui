class ResetPasswordController
  constructor: (AuthenticatorService, $scope, $routeParams, $location) ->
    @email = $routeParams.email
    @device = $routeParams.device
    @token = $routeParams.token
    @AuthenticatorService = AuthenticatorService
    @scope = $scope
    @location = $location
    @scope.$watch 'password', @verifyPasswordMatch, true
    @scope.$watch 'confirmPassword', @verifyPasswordMatch, true

  resetPassword: (password) =>
    return unless @verifyPasswordMatch()
    @AuthenticatorService.resetPassword(@device, @token, password)
      .then =>
        @location.path '/'
      .catch =>
        @errorMessage = 'An error occurred resetting your password.'

  verifyPasswordMatch: =>
    if @scope.confirmPassword?.length && @scope.password != @scope.confirmPassword
      @resetForm?.confirmPassword.$error.match = true
      return false

    @resetForm?.confirmPassword.$error.match = false
    return true


  emailRequiredError: =>
    return true if @resetForm?.email.$error.required && @resetForm?.email.$touched

  passwordRequiredError: =>
    return true if @resetForm?.password.$error.required && @resetForm?.password.$touched

  confirmPasswordError: =>
    return true if @resetForm?.confirmPassword.$error.match
    return true if @resetForm?.confirmPassword.$error.required && @resetForm?.confirmPassword.$touched


angular.module('email-password').controller 'ResetPasswordController', ResetPasswordController
