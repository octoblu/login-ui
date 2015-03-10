class AuthenticatorService
  # @HOST: "https://email-password.octoblu.com"
  # @HOST: "http://localhost:3003"

  constructor: ($q, $http, AUTHENTICATOR_URI) ->
    @q = $q
    @http = $http
    @AUTHENTICATOR_URI = AUTHENTICATOR_URI

  authenticate: (email, password, callbackUrl) =>
    @http
      .post "#{@AUTHENTICATOR_URI}/sessions", {
        email: email
        password: password
        callbackUrl: callbackUrl
      }
      .then (result) =>
        result.data.callbackUrl
      .catch (result) =>
        @q.reject result.data

  register: (email, password, callbackUrl) =>
    @http
      .post "#{@AUTHENTICATOR_URI}/devices", {
        email: email
        password: password
        callbackUrl: callbackUrl
      }
      .then (result) =>
        result.data.callbackUrl
      .catch (result) =>
        @q.reject result.data

  passwordMatches: (password, confirmPassword) =>
    password != confirmPassword

  forgotPassword: (email) =>
    @http.post("#{@AUTHENTICATOR_URI}/forgot", email: email)
      .then (result) =>
        return result.data

  resetPassword: (device, token, password) =>
    @http.post("#{@AUTHENTICATOR_URI}/reset", device: device, token: token, password: password)
      .then (result) =>
        return result.data

angular.module('email-password').service 'AuthenticatorService', AuthenticatorService

