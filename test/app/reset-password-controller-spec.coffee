describe 'ResetPasswordController', ->
  beforeEach ->
    module 'email-password'

    inject ($controller, $q, $rootScope) ->
      @q = $q
      @controller = $controller
      @rootScope = $rootScope
      @scope = @rootScope.$new()
      @location = path: sinon.stub()
      @AuthenticatorService = resetPassword: sinon.stub().returns(@q.when())
      @sut = $controller 'ResetPasswordController',
        AuthenticatorService: @AuthenticatorService
        $routeParams : {}
        $scope: @scope
        $location : @location

  describe '->constructor', ->
    describe 'when constructed with the device about to be reset', ->
      beforeEach ->
        @routeParams =
          email : 'bad@doctor.com'
          device: 'the-right-key'
          token: 'insane-robot'

        @sut = @controller 'ResetPasswordController',
          AuthenticatorService: @AuthenticatorService
          $routeParams : @routeParams
          $scope: @scope

      it 'should add an email property to itself', ->
        expect(@sut.email).to.equal 'bad@doctor.com'

      it 'should add an device property to itself', ->
        expect(@sut.device).to.equal 'the-right-key'

      it 'should add an token property to itself', ->
        expect(@sut.token).to.equal 'insane-robot'

    describe 'when constructed with the different device about to be reset', ->
      beforeEach ->
        @routeParams =
          email : 'escaped@prisoner.com'
          device: 'animal-expert'
          token: 'walk-on-water'
        @sut = @controller 'ResetPasswordController',
          AuthenticatorService: @AuthenticatorService
          $routeParams : @routeParams
          $scope: @scope

      it 'should add an email property to itself', ->
        expect(@sut.email).to.equal 'escaped@prisoner.com'

      it 'should add an device property to itself', ->
        expect(@sut.device).to.equal 'animal-expert'

      it 'should add an token property to itself', ->
        expect(@sut.token).to.equal 'walk-on-water'

  describe '->resetPassword', ->
    describe 'when called and the passwords match', ->
      beforeEach ->
        @sut.verifyPasswordMatch = sinon.stub().returns true
        @sut.device = 'love-robot'
        @sut.token = 'science'
        @scope.password = 'coolify'
        @sut.resetPassword()
        @rootScope.$digest()

      it 'should call AuthenticatorService.resetPassword with the appropriate parameters', ->
        expect(@AuthenticatorService.resetPassword).to.have.been.calledWith 'love-robot', 'science', 'coolify'

    describe 'when called and the passwords match with a different device', ->
      beforeEach ->
        @sut.verifyPasswordMatch = sinon.stub().returns true
        @sut.device = 'sad-story'
        @sut.token = 'non-lethal-shot'
        @scope.password = 'self-immolation'
        @sut.resetPassword()
        @rootScope.$digest()

      it 'should call AuthenticatorService.resetPassword with the appropriate parameters', ->
        expect(@AuthenticatorService.resetPassword).to.have.been.calledWith 'sad-story', 'non-lethal-shot', 'self-immolation'


    describe "when called and the passwords don't match", ->
      beforeEach ->
        @sut.verifyPasswordMatch = sinon.stub().returns false
        @sut.device = 'sad-story'
        @sut.token = 'non-lethal-shot'
        @scope.password = 'self-immolation'
        @sut.resetPassword()
        @rootScope.$digest()

      it 'should not call AuthenticatorService.resetPassword', ->
        expect(@AuthenticatorService.resetPassword).to.have.not.been.called

    describe "when the AuthenticatorService resolves it's promise", ->
      beforeEach ->
        @sut.verifyPasswordMatch = sinon.stub().returns true
        @sut.device = 'nine-lives'
        @sut.token = 'land-on'
        @scope.password = 'your-feet'
        @sut.resetPassword()
        @rootScope.$digest()

      it 'should redirect to login', ->
        expect(@location.path).to.have.been.calledWith '/'

      it 'should not set an error message', ->
        expect(@sut.errorMessage).to.not.exist

    describe "when the AuthenticatorService rejects it's promise", ->
      beforeEach ->
        @sut.verifyPasswordMatch = sinon.stub().returns true
        @AuthenticatorService.resetPassword.returns @q.reject()
        @sut.device = 'nine-lives'
        @sut.token = 'land-on'
        @scope.password = 'your-feet'
        @sut.resetPassword()
        @rootScope.$digest()

      it 'should not redirect to login', ->
        expect(@location.path).to.have.not.been.called

      it 'should set an error message', ->
        expect(@sut.errorMessage).to.equal 'An error occurred resetting your password.'
