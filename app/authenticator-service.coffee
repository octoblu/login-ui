class AuthenticatorService
  constructor: ($q, $http) ->
    @q = $q
    @http = $http

  authenticate: (email, password) =>
    @http.post('https://email-password.octoblu.com/sessions', {
      email: email
      password: password
    })
    .then (result) =>
      result.data

  register: (email, password) =>
    @http.post('https://email-password.octoblu.com/devices', {
      email: email
      password: password
    })
    .then (result) =>         
      result.data

angular.module('email-password').service 'AuthenticatorService', AuthenticatorService

