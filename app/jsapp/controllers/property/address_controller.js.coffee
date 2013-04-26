window.PropertyAddressController = ($scope) ->

  $scope.save = () ->
    $scope.save_property() if $scope.is_changed()

  $scope.reset = () ->
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
