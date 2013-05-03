window.ApplicationController = ($scope, $location) ->
  $scope.alert = ( options ) ->
    opts = { type: 'error' }
    $scope.noty(angular.extend(opts, options))

  $scope.notify = ( options ) ->
    opts = { type: 'success' }
    $scope.noty(angular.extend(opts, options))

  $scope.noty = ( options ) ->
    opts =
      layout: 'topCenter'
      timeout: 5000
      type: 'success'
    noty(angular.extend(opts, options))

  attributes = $('meta[name="current-user"]').attr('content')
  if attributes
    $scope.current_user = JSON.parse(attributes)
    if $scope.current_user.password_identity && $scope.current_user.password_identity.state == 'verifying'
      $scope.alert
        text: "Please verify your email address. <a href='#/verification'>Send again</a>"
        timeout: 10000
  else
    window.location = '/session/sign_in'

  $scope.errors =
    required: "can't be blank"

  $scope.body_class = 'feeds'

  $scope.set_body_class = (class_name)->
    $scope.body_class = class_name

  $scope.process_error_response = (response) ->
    switch response.status
      when 400
        response.config.data.errors = response.data.errors
        for error in response.data.errors
          $scope.alert({ text: error })
      when 404
        $location.path('/404')
      else
        $location.path('/500')

window.ApplicationController.$inject = ['$scope', '$location']
