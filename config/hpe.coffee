protocol = location.protocol.replace(/\W*$/,'')
angular.module('email-password').constant 'AUTHENTICATOR_URI', "#{protocol}://meshblu-authenticator-email-password.hpe.octoblu.com"
