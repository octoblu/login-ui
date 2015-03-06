describe 'SignupController', ->
  beforeEach ->
    module 'email-password'

    inject ($controller, $q, $rootScope, $window) ->
      @q = $q
      @rootScope = $rootScope
      @scope = $rootScope.$new()
      @routeParams = {}
      @window = location: sinon.stub()
      @AuthenticatorService = register: sinon.stub().returns @q.when()
      @sut = $controller 'SignupController',
        AuthenticatorService: @AuthenticatorService
        $routeParams: @routeParams
        $scope: @scope
        $window: @window
      @sut.signupForm =
        email: { $setTouched: => }
        password: { $setTouched: => }
        confirmPassword: { $error: {}, $setTouched: => }


  it 'should exist', ->
    expect(@sut).to.exist

  it 'should have a signup function', ->
    expect(@sut.signup).to.exist

  describe 'when the signup function is called', ->

    describe 'when email, password and confirmPassword are valid', ->
      beforeEach ->
        @email = 'parachute@failure.io'
        @password = 'happenstance'
        @sut.formIsValid = sinon.stub().returns true
        @confirmPassword = 'happenstance'
        @sut.signup @email, @password, @confirmPassword
        @rootScope.$digest()

      it 'should call formIsValid', ->
        expect(@sut.formIsValid).to.have.been.called

      it 'should call the signup service', ->
        expect(@AuthenticatorService.register).to.have.been.calledWith @email, @password, 'https://app.octoblu.com/api/session'

    describe 'when AuthenticatorService resolves the promise', ->
      beforeEach ->
        @email = "faulty@machinery"
        @password = "execution"
        @uuid = "failing"
        @token = "tree"
        @sut.formIsValid = sinon.stub().returns true
        @AuthenticatorService.register.returns @q.when('http://foo.blarg')
        @sut.signup @email, @password, @password
        @rootScope.$digest()

      it 'should call formIsValid', ->
        expect(@sut.formIsValid).to.have.been.called

      it 'should return a uuid and token', ->
        expect(@AuthenticatorService.register).to.have.been.calledWith @email, @password

      it 'should redirect to the callback url with that uuid and token', ->
        expect(@window.location).to.deep.equal 'http://foo.blarg'

    describe 'when AuthenticatorService rejects the promise', ->
      beforeEach ->
        @email = "faulty@machinery"
        @password = "execution"
        @sut.formIsValid = sinon.stub().returns true
        @AuthenticatorService.register.returns @q.reject(error: new Error('oh no'))
        @sut.signup @email, @password, @password
        @rootScope.$digest()

      it 'should call formIsValid', ->
        expect(@sut.formIsValid).to.have.been.called

      it 'should set the errorMessage', ->
        expect(@sut.errorMessage).to.deep.equal new Error('oh no')
