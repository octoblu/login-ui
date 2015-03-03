describe 'AuthenticatorService', ->
  beforeEach ->
    module 'email-password', =>
      return

    inject ($httpBackend, $rootScope, AuthenticatorService) =>
      @rootScope = $rootScope
      @httpBackend = $httpBackend
      @sut = AuthenticatorService

  it 'should exist', ->
    expect(@sut).to.exist

  describe '->register', ->
    beforeEach ->
      @signupUrl = 'https://email-password.octoblu.com/devices'

    describe 'when called', ->
      it 'should post to signup.octoblu.com with the email and password', ->
        @email = 'taft@president.org'
        @password = 'bathtub'
        @httpBackend.expectPOST(@signupUrl, {
            email: @email
            password: @password
          }
        ).respond()

        @sut.register @email, @password
        @httpBackend.flush()

      it 'should post another email and password to  signup.octoblu.com/register', ->
        @email = 'impeachthe@president.org'
        @password = 'publice'
        @httpBackend.expectPOST(@signupUrl, {
            email: @email
            password: @password
          }
        ).respond()

        @sut.register @email, @password
        @httpBackend.flush()

    describe 'when the service responds with a non-201', ->
      beforeEach ->
        @email = 'complicated'
        @password = 'dolphin'
        @httpBackend.expectPOST(@signupUrl,
          email: @email
          password: @password
        ).respond(401, 'you done screwed up')

      describe 'when it is called with an email and password', ->
        it 'should reject the promise and return the error', (done) ->
          @sut.register(@email,@password).catch (error) =>
            expect(error.data).to.equal 'you done screwed up'
            done()
          @httpBackend.flush()
