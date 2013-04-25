window.PropertyDescriptionController = ($scope) ->

  $scope.save = () ->
    $scope.save_property() if $scope.is_changed()

  $scope.reset = () ->
    $scope.property.description = $scope.property_cached.description

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.property.description != $scope.property_cached.description

window.PropertyDescriptionController.$inject = ['$scope']
