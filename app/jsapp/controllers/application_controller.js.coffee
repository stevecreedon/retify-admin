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
        $scope.server_errors = response.data.errors.full_messages
      when 404
        $location.path('/404')
      else
        $location.path('/500')


window.ApplicationController.$inject = ['$scope', '$location']
