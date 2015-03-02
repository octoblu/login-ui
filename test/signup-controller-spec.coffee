describe 'SignupController', ->
  beforeEach ->
    module 'email-password'

    inject ($controller, $q, $rootScope) ->
      @q = $q
      @rootScope = $rootScope
      @sut = $controller 'SignupController'

  it 'should exist', ->
    expect(@sut).to.exist

  it 'should have a signup function', ->
    expect(@sut.signup).to.exist

  describe 'when the signup function is called', ->
     
    describe 'when the email address is empty', -> 
      beforeEach -> 
        @email = ''
        @password = '1234'
        @confirmPassword = '1234'
        @sut.signup @email, @password, @confirmPassword
      it 'should set the errorMessage to say the email field cannot be blank', ->
        expect(@sut.errorMessage).to.deep.equal "Please enter a valid email address"

    describe 'when the email address is not empty', -> 
      beforeEach -> 
        @email = 'sabotage@roller.coaster'
        @password = '1234'
        @confirmPassword = '1234'
        @sut.signup @email, @password, @confirmPassword
      
      it 'should not set the errorMessage', ->
        expect(@sut.errorMessage).to.not.exist

    describe 'when the password is empty', -> 
      beforeEach ->
        @email = 'radiation@practical.joke'
        @password = ''
        @confirmPassword = ''
        @sut.signup @email, @password, @confirmPassword

      it 'should set the error message to say the password field cannot be blank', ->
        expect(@sut.errorMessage).to.deep.equal "Password field cannot be blank"

    describe 'when password and confirmPassword do not match', ->
      beforeEach ->
        @email = 'inabilityTo@understand.metaphors'
        @password = 'laser'
        @confirmPassword = 'old map'
        @sut.signup @email, @password, @confirmPassword

      it 'should set the errorMessage', ->
        expect(@sut.errorMessage).to.deep.equal "Passwords don't match"





