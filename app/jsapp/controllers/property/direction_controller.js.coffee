window.PropertyDirectionController = ($scope, PropertyDirection) ->
  $scope.save = () ->
    if $scope.is_changed()
      new PropertyDirection($scope.direction).$update ( (resource, header)->
        $scope.direction = resource
        $scope.direction_cached.description = $scope.direction.description
      ), $scope.process_error_response

  $scope.reset = () ->
    $scope.direction.description = $scope.direction_cached.description

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.direction.description != $scope.direction_cached.description

window.PropertyDirectionController.$inject = ['$scope', 'PropertyDirection']
