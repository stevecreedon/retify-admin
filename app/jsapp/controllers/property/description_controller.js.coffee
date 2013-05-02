window.PropertyDescriptionController = ($scope) ->
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid && $scope.is_changed()
      $scope.save_property(message: 'Property description was saved')

  $scope.reset = () ->
    $scope.submited = false
    $scope.property.description = $scope.property_cached.description

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.property.description != $scope.property_cached.description

window.PropertyDescriptionController.$inject = ['$scope']
