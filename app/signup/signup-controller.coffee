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
    @errorMessage = SignupController.ERROR_NO_EMAIL unless email
    @errorMessage = SignupController.ERROR_NO_PASSWORD unless password
    @errorMessage = SignupController.ERROR_PASSWORDS_MATCH unless confirmPassword == password

    @AuthenticatorService.register(email, password)
    .then (result) =>
      @window.location = "#{@redirectURL}?uuid=#{result.uuid}&token=#{result.token}"
    .catch =>
      @errorMessage = SignupController.ERROR_REGISTERING

  verifyPasswordMatch: =>
    if @scope.confirmPassword?.length and @scope.password isnt @scope.confirmPassword
      @signupForm?.confirmPassword.$error.match = true
    else
      @signupForm?.confirmPassword.$error.match = false

  confirmPasswordError: =>
    return true if @signupForm?.confirmPassword.$error.match
    return true if @signupForm?.confirmPassword.$error.required && @signupForm?.confirmPassword.$touched

  emailRequiredError: =>
    return true if @signupForm?.email.$error.required && @signupForm?.email.$touched

  passwordRequiredError: =>
    return true if @signupForm?.password.$error.required && @signupForm?.password.$touched

angular.module('email-password').controller 'SignupController', SignupController
