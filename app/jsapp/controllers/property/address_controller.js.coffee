window.PropertyAddressController = ($scope) ->
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid && $scope.is_changed()
      $scope.block()
      $scope.property.$update (model, header)->
        $scope.property_cached.address = angular.copy $scope.property.address
        $scope.notify.success text: 'Property address was saved'
        $scope.unblock()

  $scope.reset = () ->
    $scope.submited = false
    $scope.property.address.address   = $scope.property_cached.address.address
    $scope.property.address.city      = $scope.property_cached.address.city
    $scope.property.address.country   = $scope.property_cached.address.country
    $scope.property.address.post_code = $scope.property_cached.address.post_code

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.property.address.address   != $scope.property_cached.address.address ||
    $scope.property.address.city      != $scope.property_cached.address.city ||
    $scope.property.address.country   != $scope.property_cached.address.country ||
    $scope.property.address.post_code != $scope.property_cached.address.post_code

window.PropertyAddressController.$inject = ['$scope']
