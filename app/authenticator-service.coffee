class AuthenticatorService
  constructor: ($q, $http) ->
    @q = $q
    @http = $http

  authenticate: (email, password) =>
    @http
      .post 'https://email-password.octoblu.com/sessions', {
        email: email
        password: password
      }
      .catch (result) =>
        result.data

  register: (email, password) =>
    @http
      .post 'https://email-password.octoblu.com/devices', {
        email: email
        password: password
      }
      .catch (result) =>
        result.data

  passwordMatches: (password, confirmPassword) =>
    password != confirmPassword

angular.module('email-password').service 'AuthenticatorService', AuthenticatorService

