window.ApplicationController = ['$scope', ($scope) ->
  attributes = $('meta[name="current-user"]').attr('content')
  if attributes
    $scope.currentUser = JSON.parse(attributes)
  else
    window.location = '/session/sign_in'

  $scope.errors =
    required: "can't be blank"

]
