class SignupController
  @ERROR_NO_EMAIL: "Please enter a valid email address"
  @ERROR_NO_PASSWORD : "Password field cannot be blank"
  @ERROR_PASSWORDS_MATCH: "Passwords don't match"

  constructor: () ->

  signup: (email, password, confirmPassword) =>
    @errorMessage = SignupController.ERROR_NO_EMAIL unless email
    @errorMessage = SignupController.ERROR_NO_PASSWORD unless password
    @errorMessage = SignupController.ERROR_PASSWORDS_MATCH unless confirmPassword == password

angular.module('email-password').controller 'SignupController', SignupController
