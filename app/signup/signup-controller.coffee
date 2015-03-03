class SignupController
  @ERROR_NO_EMAIL: "Please enter a valid email address"
  @ERROR_NO_PASSWORD : "Password field cannot be blank"
  @ERROR_PASSWORDS_MATCH: "Passwords don't match"
  @ERROR_REGISTERING: "Error registering with meshblu"

  constructor: (SignupService, $location, $window) ->
    @SignupService = SignupService
    @window = $window
    @location = $location

  signup: (email, password, confirmPassword) =>
    @errorMessage = SignupController.ERROR_NO_EMAIL unless email
    @errorMessage = SignupController.ERROR_NO_PASSWORD unless password
    @errorMessage = SignupController.ERROR_PASSWORDS_MATCH unless confirmPassword == password

    @SignupService.register(email, password)
    .then (result) =>
      @window.location = "#{@location.params.redirectURL}?uuid=#{result.uuid}&token=#{result.token}"
    .catch =>
      @errorMessage = SignupController.ERROR_REGISTERING      

angular.module('email-password').controller 'SignupController', SignupController
