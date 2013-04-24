window.ApplicationController = ($scope) ->
  attributes = $('meta[name="current-user"]').attr('content')
  if attributes
    $scope.currentUser = JSON.parse(attributes)
  else
    window.location = '/session/sign_in'

  $scope.errors =
    required: "can't be blank"

  $scope.body_class = 'feeds'

  $scope.set_body_class = (class_name)->
    $scope.body_class = class_name

window.ApplicationController.$inject = ['$scope']
