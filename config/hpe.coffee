return unless location.hostname.indexOf('hpe.octoblu.com') > -1
protocol = location.protocol.replace(/\W*$/,'')
angular.module('email-password').constant 'AUTHENTICATOR_URI', "#{protocol}://email-password.hpe.octoblu.com"
