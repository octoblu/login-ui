return unless location.hostname == 'localhost'
angular.module('email-password').constant 'AUTHENTICATOR_URI', "http://localhost:3003"
