window.PropertyTitleController = ($scope) ->
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid && $scope.is_changed()
      $scope.save_property(message: 'Property title was saved')

  $scope.reset = () ->
    $scope.submited = false
    $scope.property.title = $scope.property_cached.title

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.property.title != $scope.property_cached.title

window.PropertyTitleController.$inject = ['$scope']
