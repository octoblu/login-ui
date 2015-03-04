describe 'LoginController', ->
  beforeEach ->
    module 'email-password'

    inject ($controller, $q, $rootScope) ->
      @q = $q
      @rootScope = $rootScope
      @AuthenticatorService = authenticate: sinon.stub().returns @q.when()
      @routeParams = {}
      @sut = $controller 'LoginController',
        $routeParams: @routeParams
        AuthenticatorService: @AuthenticatorService
      @sut.loginForm =
        $valid: true
        email: {'$setTouched': =>}
        password: {'$setTouched': =>}

  describe '->login', ->
    describe 'when routeParams has a callback url', ->
      beforeEach ->
        @routeParams.callback = 'zombo.com'

      describe 'when called with a email and password', ->
        beforeEach ->
          @sut.login 'r@go.co', 'sliced'
          @rootScope.$digest()

        it 'should call AuthenticatorService.authenticate with the email and password', ->
          expect(@AuthenticatorService.authenticate).to.have.been.calledWith 'r@go.co', 'sliced', 'zombo.com'

    describe 'when routeParams has a callback url', ->
      beforeEach ->
        @routeParams.callback = 'cats.com'

      describe 'when called with a email and password', ->
        beforeEach ->
          @sut.login 'r@go.co', 'sliced'
          @rootScope.$digest()

        it 'should call AuthenticatorService.authenticate with the email and password', ->
          expect(@AuthenticatorService.authenticate).to.have.been.calledWith 'r@go.co', 'sliced', 'cats.com'

    describe 'when called and authenticate resolves an error', ->
      beforeEach ->
        @AuthenticatorService.authenticate.returns @q.when('ERROR')
        @sut.login 'r@go.co', 'sliced'
        @rootScope.$digest()

      it 'should add ERROR to the errorMessage on the scope', ->
        expect(@sut.errorMessage).to.equal 'ERROR'
