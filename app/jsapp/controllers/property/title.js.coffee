window.PropertyTitleController = ($scope) ->

  $scope.save = () ->
    $scope.save_property() if $scope.is_changed()

  $scope.reset = () ->
    $scope.property.title = $scope.property_cached.title

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.property.title != $scope.property_cached.title

window.PropertyTitleController.$inject = ['$scope']
