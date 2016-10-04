return unless location.hostname.indexOf('octoblu.test') > -1
console.log 'using octoblu-test env'
protocol = location.protocol.replace(/\W*$/,'')
angular.module('email-password')
  .constant 'AUTHENTICATOR_URI', "#{protocol}://email-password.octoblu.test"
