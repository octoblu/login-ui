class AuthenticatorService
  @HOST: "https://email-password.octoblu.com"
  # @HOST: "http://localhost:3003"

  constructor: ($q, $http) ->
    @q = $q
    @http = $http

  authenticate: (email, password, callbackUrl) =>
    @http
      .post "#{AuthenticatorService.HOST}/sessions", {
        email: email
        password: password
        callbackUrl: callbackUrl
      }
      .then (result) =>
        result.data.callbackUrl
      .catch (result) =>
        @q.reject result.data

  register: (email, password) =>
    @http
      .post "#{AuthenticatorService.HOST}/devices", {
        email: email
        password: password
      }
      .catch (result) =>
        result.data

  passwordMatches: (password, confirmPassword) =>
    password != confirmPassword

  forgotPassword: (email) =>
    @http.post("#{AuthenticatorService.HOST}/forgot", email: email)
      .then (result) =>
        return result.data

angular.module('email-password').service 'AuthenticatorService', AuthenticatorService

