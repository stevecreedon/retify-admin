window.ApplicationController = ($scope, $location) ->
  attributes = $('meta[name="current-user"]').attr('content')
  if attributes
    $scope.current_user = JSON.parse(attributes)
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
        response.config.data.errors.full_messages = response.data.errors.full_messages
        for error in response.data.errors.full_messages
          $scope.alert({ text: error })
      when 404
        $location.path('/404')
      else
        $location.path('/500')

  $scope.alert = ( options ) ->
    opts = { type: 'error' }
    $scope.noty(angular.extend(opts, options))

  $scope.notify = ( options ) ->
    opts = { type: 'error' }
    $scope.noty(angular.extend(opts, options))

  $scope.noty = ( options ) ->
    opts =
      layout: 'topCenter'
      timeout: 5000
      type: 'success'
    noty(angular.extend(opts, options))

window.ApplicationController.$inject = ['$scope', '$location']
