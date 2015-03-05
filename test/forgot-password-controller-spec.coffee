describe 'ForgotPasswordController', ->
  beforeEach ->
    module 'email-password'

    inject ($controller, $q, $rootScope) ->
      @q = $q
      @rootScope = $rootScope
      @AuthenticatorService = forgotPassword: sinon.stub().returns(@q.when())
      @sut = $controller 'ForgotPasswordController',
        AuthenticatorService: @AuthenticatorService

  describe '->forgotPassword', ->

    describe 'when called with an email', ->
      beforeEach ->
        @sut.forgotPassword("peter@bacon.com")
        @rootScope.$digest()

      it 'should call AuthenticatorService.forgotPassword with peter@bacon.com', ->
        expect(@AuthenticatorService.forgotPassword).to.have.been.calledWith 'peter@bacon.com'

    describe 'when called with a different email', ->
      beforeEach ->
        @sut.forgotPassword("aaron@isnt-cool-enough-for-bacon.com")
        @rootScope.$digest()

      it 'should call AuthenticatorService.forgotPassword with aaron@isnt-cool-enough-for-bacon.com', ->
        expect(@AuthenticatorService.forgotPassword).to.have.been.calledWith 'aaron@isnt-cool-enough-for-bacon.com'

    describe "when AuthenticatorService.forgotPassword resolves it's promise", ->
      beforeEach ->
        @AuthenticatorService.forgotPassword.returns @q.when()
        @sut.forgotPassword "yes@aaron-totally-is.com"
        @rootScope.$digest()

      it "should add a message", ->
        expect(@sut.message).to.equal 'An email has been sent.'

      it "should not add an error message", ->
        expect(@sut.errorMessage).to.not.exist

    describe "when AuthenticatorService.forgotPassword rejects it's promise", ->
      beforeEach ->
        @AuthenticatorService.forgotPassword.returns @q.reject()
        @sut.forgotPassword "yes@aaron-totally-is.com"
        @rootScope.$digest()

      it "should not add a message", ->
        expect(@sut.message).to.not.exist

      it "should add an errorMessage", ->
        expect(@sut.errorMessage).to.equal 'Error resetting your password'

