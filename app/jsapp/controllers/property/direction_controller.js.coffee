window.PropertyDirectionController = ($scope, PropertyDirection) ->
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid && $scope.is_changed()
      $scope.block()
      new PropertyDirection($scope.direction).$update (resource, header)->
        $scope.direction = resource
        $scope.direction_cached.description = $scope.direction.description
        $scope.notify.success text: 'Direction was saved'
        $scope.unblock()

  $scope.reset = () ->
    $scope.submited = false
    $scope.direction.description = $scope.direction_cached.description

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.direction.description != $scope.direction_cached.description

window.PropertyDirectionController.$inject = ['$scope', 'PropertyDirection']
