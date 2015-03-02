describe 'SignupController', ->
  beforeEach ->
    module 'email-password'

    inject ($controller, $q, $rootScope) ->
      @q = $q
      @rootScope = $rootScope
      @sut = $controller 'SignupController'

  it 'should exist'
    expect(@sut).to.exist 