class SignupController
  @ERROR_NO_EMAIL: "Please enter a valid email address"
  @ERROR_NO_PASSWORD : "Password field cannot be blank"
  @ERROR_PASSWORDS_MATCH: "Passwords don't match"
  @ERROR_REGISTERING: "Error registering with meshblu"

  constructor: (AuthenticatorService, $window, $routeParams) ->
    @AuthenticatorService = AuthenticatorService
    @window = $window
    @redirectURL = $routeParams.redirect

  signup: (email, password, confirmPassword) =>
    @errorMessage = SignupController.ERROR_NO_EMAIL unless email
    @errorMessage = SignupController.ERROR_NO_PASSWORD unless password
    @errorMessage = SignupController.ERROR_PASSWORDS_MATCH unless confirmPassword == password

    @AuthenticatorService.register(email, password)
    .then (result) =>
      @window.location = "#{@redirectURL}?uuid=#{result.uuid}&token=#{result.token}"
    .catch =>
      @errorMessage = SignupController.ERROR_REGISTERING      

angular.module('email-password').controller 'SignupController', SignupController
