describe 'LoginController', ->
  beforeEach ->
    module 'email-password'

    inject ($controller, $q, $rootScope) ->
      @q = $q
      @rootScope = $rootScope
      @AuthenticatorService = authenticate: sinon.stub().returns @q.when()
      @routeParams = {}
      @window = {}
      @controller = $controller
      @sut = @controller 'LoginController',
        $routeParams: @routeParams
        $window: @window
        AuthenticatorService: @AuthenticatorService
      @sut.loginForm =
        $valid: true
        email: {'$setTouched': =>}
        password: {'$setTouched': =>}

  describe '->constructor', ->
    describe 'when instantiated', ->
      beforeEach ->
        @routeParams.callback = 'http%3A%2F%2Fsomething.cool.really.cool'
        @sut = @controller 'LoginController',
          $routeParams: @routeParams
          $window: @window
          AuthenticatorService: @AuthenticatorService
        @sut.loginForm =
          $valid: true
          email: {'$setTouched': =>}
          password: {'$setTouched': =>}

      it 'should set the signupPath', ->
        expect(@sut.signupPath).to.equal '/signup?callback=http%3A%2F%2Fsomething.cool.really.cool'

  describe '->login', ->
    describe 'when routeParams no has a callback url', ->
      beforeEach ->
        @sut = @controller 'LoginController',
          $routeParams: @routeParams
          $window: @window
          AuthenticatorService: @AuthenticatorService
        @sut.loginForm =
          $valid: true
          email: {'$setTouched': =>}
          password: {'$setTouched': =>}

      describe 'when called with a email and password', ->
        beforeEach ->
          @sut.login 'r@go.co', 'sliced'
          @rootScope.$digest()

        it 'should call AuthenticatorService.authenticate with the email, password, and default callback', ->
          expect(@AuthenticatorService.authenticate).to.have.been.calledWith 'r@go.co', 'sliced', 'https%3A%2F%2Fapp.octoblu.com%2Fapi%2Fsession'

    describe 'when routeParams has a callback url', ->
      beforeEach ->
        @routeParams.callback = 'zombo.com'
        @sut = @controller 'LoginController',
          $routeParams: @routeParams
          $window: @window
          AuthenticatorService: @AuthenticatorService
        @sut.loginForm =
          $valid: true
          email: {'$setTouched': =>}
          password: {'$setTouched': =>}

      describe 'when called with a email and password', ->
        beforeEach ->
          @sut.login 'r@go.co', 'sliced'
          @rootScope.$digest()

        it 'should call AuthenticatorService.authenticate with the email and password', ->
          expect(@AuthenticatorService.authenticate).to.have.been.calledWith 'r@go.co', 'sliced', 'zombo.com'

    describe 'when routeParams has a callback url', ->
      beforeEach ->
        @routeParams.callback = 'cats.com'
        @sut = @controller 'LoginController',
          $routeParams: @routeParams
          $window: @window
          AuthenticatorService: @AuthenticatorService
        @sut.loginForm =
          $valid: true
          email: {'$setTouched': =>}
          password: {'$setTouched': =>}

      describe 'when called with a email and password', ->
        beforeEach ->
          @sut.login 'r@go.co', 'sliced'
          @rootScope.$digest()

        it 'should call AuthenticatorService.authenticate with the email and password', ->
          expect(@AuthenticatorService.authenticate).to.have.been.calledWith 'r@go.co', 'sliced', 'cats.com'

    describe 'when called and authenticate resolves an error', ->
      beforeEach ->
        @AuthenticatorService.authenticate.returns @q.reject('ERROR')
        @sut.login 'r@go.co', 'sliced'
        @rootScope.$digest()

      it 'should add ERROR to the errorMessage on the scope', ->
        expect(@sut.errorMessage).to.equal 'ERROR'

    describe 'when called and authenticate resolves', ->
      beforeEach ->
        @AuthenticatorService.authenticate.returns @q.when('cats.com?uuid=goose&token=duck-duck-dead')
        @sut.login 'r@go.co', 'sliced'
        @rootScope.$digest()

      it 'should redirect the user to the callback url', ->
        expect(@window.location).to.equal 'cats.com?uuid=goose&token=duck-duck-dead'

    describe 'when called, authenticate resolves, but callback already had query params', ->
      beforeEach ->
        @AuthenticatorService.authenticate.returns @q.when('goat.se?foo=bar&uuid=hang&token=glider')
        @sut.login 'r@go.co', 'sliced'
        @rootScope.$digest()

      it 'should redirect the user to the callback url', ->
        expect(@window.location).to.equal 'goat.se?foo=bar&uuid=hang&token=glider'
