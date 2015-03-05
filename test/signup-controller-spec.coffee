describe 'SignupController', ->
  beforeEach ->
    module 'email-password'

    inject ($controller, $q, $rootScope, $window) ->
      @q = $q
      @rootScope = $rootScope
      @scope = $rootScope.$new()
      @routeParams = redirect: "https://app.octoblu.com/api/sessions"
      @window = location: sinon.stub()
      @AuthenticatorService = register: sinon.stub().returns @q.when()
      @sut = $controller 'SignupController',
        AuthenticatorService: @AuthenticatorService
        $routeParams: @routeParams
        $scope: @scope
        $window: @window


  it 'should exist', ->
    expect(@sut).to.exist

  it 'should have a signup function', ->
    expect(@sut.signup).to.exist

  describe 'when the signup function is called', ->
    # describe 'when the email address is empty', ->
    #   beforeEach ->
    #     @email = ''
    #     @password = '1234'
    #     @confirmPassword = '1234'
    #     @sut.signup @email, @password, @confirmPassword
    #     return
    #
    #   it 'should set the errorMessage to say the email field cannot be blank', ->
    #     expect(@sut.errorMessage).to.deep.equal "Please enter a valid email address"

    # describe 'when the email address is not empty', ->
    #   beforeEach ->
    #     @email = 'sabotage@roller.coaster'
    #     @password = '1234'
    #     @confirmPassword = '1234'
    #     @sut.signup @email, @password, @confirmPassword
    #     return
    #
    #   it 'should not set the errorMessage', ->
    #     expect(@sut.errorMessage).to.not.exist

    # describe 'when the password is empty', ->
    #   beforeEach ->
    #     @email = 'radiation@practical.joke'
    #     @password = ''
    #     @confirmPassword = ''
    #     @sut.signup @email, @password, @confirmPassword
    #     return
    #
    #   it 'should set the error message to say the password field cannot be blank', ->
    #     expect(@sut.errorMessage).to.deep.equal "Password field cannot be blank"

    # describe 'when password and confirmPassword do not match', ->
    #   beforeEach ->
    #     @email = 'inabilityTo@understand.metaphors'
    #     @password = 'laser'
    #     @confirmPassword = 'old map'
    #     @sut.signup @email, @password, @confirmPassword
    #     return
    #
    #   it 'should set the errorMessage', ->
    #     expect(@sut.errorMessage).to.deep.equal "Passwords don't match"

    describe 'when email, password and confirmPassword are valid', ->
      beforeEach ->
        @email = 'parachute@failure.io'
        @password = 'happenstance'
        @confirmPassword = 'happenstance'
        @sut.signup @email, @password, @confirmPassword
        return

      it 'should call the signup service', ->
        expect(@AuthenticatorService.register).to.have.been.called

    describe 'when AuthenticatorService resolves the promise', ->
      beforeEach ->
        @email = "faulty@machinery"
        @password = "execution"
        @uuid = "failing"
        @token = "tree"
        @redirectURL = "https://app.octoblu.com/api/sessions?uuid=#{@uuid}&token=#{@token}"
        @AuthenticatorService.register.returns @q.when(uuid: @uuid, token: @token)
        @sut.signup @email, @password, @password
        @rootScope.$digest()

      it 'should return a uuid and token', ->
        expect(@AuthenticatorService.register).to.have.been.calledWith @email, @password

      it 'should redirect to the callback url with that uuid and token', ->
        expect(@window.location).to.deep.equal @redirectURL

    describe 'when AuthenticatorService rejects the promise', ->
      beforeEach ->
        @email = "faulty@machinery"
        @password = "execution"
        @AuthenticatorService.register.returns @q.reject(new Error('oh no'))
        @sut.signup @email, @password, @password
        @rootScope.$digest()

      it 'should set the errorMessage', ->
        expect(@sut.errorMessage).to.deep.equal "Error registering with meshblu"
