describe 'AuthenticatorService', ->
  beforeEach ->
    module 'email-password', ($provide) =>
      @http = post: sinon.stub()
      $provide.value '$http', @http
      return

    inject ($q, $rootScope, AuthenticatorService) =>
      @q = $q
      @rootScope = $rootScope
      @sut = AuthenticatorService

  describe '->authenticate', ->
    describe 'when called with a email, password, and a callbackUrl', ->
      beforeEach ->
        @http.post.returns @q.when({})
        @sut.authenticate 'sliced@diced.net', 'one-easy-payment'
        @rootScope.$digest()

      it 'should call POST /sessions', ->
        url = 'https://email-password.octoblu.com/sessions'
        params =
          email: 'sliced@diced.net'
          password: 'one-easy-payment'

        expect(@http.post).to.have.been.calledWith url, params

  describe '->register', ->
    describe 'when called', ->
      beforeEach ->
        @http.post.returns @q.when({})
        @sut.register 'taft@president.org', 'bathtub'
        @rootScope.$digest()

      it 'should post to signup.octoblu.com with the email and password', ->
        url = 'https://email-password.octoblu.com/devices'
        params =
          email: 'taft@president.org'
          password: 'bathtub'
        expect(@http.post).to.have.been.calledWith url, params

    describe 'when called and the service rejects', ->
      beforeEach (done) ->
        @http.post.returns @q.reject({data: 'you done screwed up'})
        @sut.register 'complicated', 'dolphin'
            .then (@errorMessage) => done()
        @rootScope.$digest()

      it 'should reject the promise and return the error', ->
        expect(@errorMessage).to.equal 'you done screwed up'
