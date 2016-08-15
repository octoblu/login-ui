return unless location.hostname.indexOf('octoblu.dev') > -1
protocol = location.protocol.replace(/\W*$/,'')
angular.module('email-password').constant 'AUTHENTICATOR_URI', "#{protocol}://meshblu-authenticator-email-password.octoblu.dev"
