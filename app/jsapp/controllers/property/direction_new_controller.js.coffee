window.PropertyDirectionNewController = ($scope, PropertyDirection) ->
  $scope.groups = [
    'By foot',
    'By car',
    'By bus',
    'By train',
    'By plane'
  ]

  for direction in $scope.property.directions
    $scope.groups.splice($scope.groups.indexOf(direction.title), 1)

  $scope.direction = new PropertyDirection({ property_id : $scope.property.id })

  $scope.save = () ->
    $scope.submited = true
    $scope.direction.$save (->
      $scope.property_cached.directions.push($scope.direction)
      $scope.property.directions = angular.copy $scope.property_cached.directions
      $scope.show('directions', $scope.direction.title)
    ), $scope.process_error_response

  $scope.reset = () ->
    $scope.direction.description = $scope.direction_cached.description

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.direction.description != $scope.direction_cached.description

window.PropertyDirectionNewController.$inject = ['$scope', 'PropertyDirection']
