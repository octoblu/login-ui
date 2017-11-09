return if location.hostname in ['localhost', 'octoblu.dev', 'octoblu.test', 'login.octoblu.com']
protocol = location.protocol.replace(/\W*$/,'')
hostname = location.hostname.split('.')[1..-1].join('.')
angular.module('email-password').constant 'AUTHENTICATOR_URI', protocol + "://email-password." + hostname
