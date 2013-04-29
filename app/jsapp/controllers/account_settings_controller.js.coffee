window.AccountSettingsController = ($scope, Identity) ->
  $scope.identity = new Identity()

  $scope.set_body_class   'properties'
  $scope.submited       = false

  $scope.save = () ->
    $scope.submited     = true
    if $scope.form.$valid
      $scope.identity.$save ( ->
        $scope.submited = false
      ), $scope.process_error_response

  $scope.cancel = ->
    $scope.submited     = false
    $scope.identity     = new Identity()

window.AccountSettingsController.$inject = ['$scope', 'Identity']
