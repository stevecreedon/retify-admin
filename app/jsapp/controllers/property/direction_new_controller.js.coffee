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
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid
      $scope.direction.$save ( (resource, headers) ->
        $scope.direction = resource
        $scope.property_cached.directions.push($scope.direction)
        $scope.property.directions = angular.copy $scope.property_cached.directions
        $scope.show('directions', $scope.direction.title)
        $scope.notify text: 'Direction was created'
      ), $scope.process_error_response

  $scope.reset = () ->
    $scope.submited = false
    $scope.direction.description = $scope.direction_cached.description

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

window.PropertyDirectionNewController.$inject = ['$scope', 'PropertyDirection']
