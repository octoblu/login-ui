class SignupController
  @ERROR_NO_EMAIL: "Please enter a valid email address"
  @ERROR_NO_PASSWORD : "Password field cannot be blank"
  @ERROR_PASSWORDS_MATCH: "Passwords don't match"
  @ERROR_REGISTERING: "Error registering with meshblu"

  constructor: (AuthenticatorService, $window, $routeParams, $scope) ->
    @AuthenticatorService = AuthenticatorService
    @window = $window
    @redirectURL = $routeParams.redirect
    @scope = $scope

    $scope.$watch 'password', @verifyPasswordMatch, true
    $scope.$watch 'confirmPassword', @verifyPasswordMatch, true

  signup: (email, password, confirmPassword) =>
    @signupForm?.email.$setTouched()
    @signupForm?.password.$setTouched()
    @signupForm?.confirmPassword.$setTouched()

    @AuthenticatorService.register(email, password)
    .then (result) =>
      @window.location = "#{@redirectURL}?uuid=#{result.uuid}&token=#{result.token}"
    .catch =>
      @errorMessage = SignupController.ERROR_REGISTERING

  verifyPasswordMatch: =>
    if @scope.confirmPassword?.length && @scope.password != @scope.confirmPassword
      @signupForm?.confirmPassword.$error.match = true
    else
      @signupForm?.confirmPassword.$error.match = false

  emailRequiredError: =>
    return true if @signupForm?.email.$error.required && @signupForm?.email.$touched

  passwordRequiredError: =>
    return true if @signupForm?.password.$error.required && @signupForm?.password.$touched

  confirmPasswordError: =>
    return true if @signupForm?.confirmPassword.$error.match
    return true if @signupForm?.confirmPassword.$error.required && @signupForm?.confirmPassword.$touched

angular.module('email-password').controller 'SignupController', SignupController
