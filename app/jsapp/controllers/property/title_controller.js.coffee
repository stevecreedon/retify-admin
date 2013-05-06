window.PropertyTitleController = ($scope) ->
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid && $scope.is_changed()
      $scope.block()
      $scope.property.$update (model, header)->
        $scope.property_cached.title = $scope.property.title
        $scope.notify.success text: 'Property title was saved'
        $scope.unblock()

  $scope.reset = () ->
    $scope.submited = false
    $scope.property.title = $scope.property_cached.title

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.property.title != $scope.property_cached.title

window.PropertyTitleController.$inject = ['$scope']
