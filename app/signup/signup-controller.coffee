class RegisterController
  ERROR_NO_PASSWORD : "Password cannot be empty"

  constructor: ($cookies, $location, AuthenticatorService) ->
    @cookies  = $cookies
    @location = $location
    @AuthenticatorService = AuthenticatorService

    @location.path "/#{@cookies.uuid}" if @cookies.uuid?

  register: (pin) =>
    return @errorMessage = @ERROR_NO_PIN if _.isEmpty pin
    return @errorMessage = @ERROR_PIN_NOT_NUMERIC unless /^\d+$/.test pin
    @AuthenticatorService.registerWithPin(pin)
    .then (res) =>
      @cookies.uuid = res.uuid
      @cookies.token = res.token
      @location.path "/#{res.uuid}"
    .catch =>
      @errorMessage = "Unable to register a new device. Please try again."

angular.module('email-password').controller 'RegisterController', RegisterController
