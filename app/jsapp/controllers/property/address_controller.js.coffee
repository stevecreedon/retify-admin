window.PropertyAddressController = ($scope, Geocode) ->
  $scope.submited = false
  $scope.geocode = new Geocode()

  $scope.save = () ->
    $scope.submited = true
    if $scope.property.address.lat
      if $scope.form.$valid && $scope.is_changed()
        $scope.block()
        $scope.property.$update (model, header)->
          $scope.property_cached.address = angular.copy $scope.property.address
          $scope.notify.success text: 'Property address was saved'
          $scope.unblock()
    else
      $scope.notify.alert text: 'Please enter correct address'

  $scope.reset = () ->
    $scope.submited = false
    angular.extend $scope.property.address, $scope.property_cached.address

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    !angular.equals $scope.property.address, $scope.property_cached.address

  $scope.check_address = ->
    $scope.geocode.find_with_timeout $scope.property.address, 1500, (address) ->
      $scope.$apply ->
        $scope.addresses = [ address ]
        angular.extend $scope.property.address, address
    , (addresses) ->
      $scope.$apply ->
        $scope.addresses = addresses

  $scope.check_address()

window.PropertyAddressController.$inject = ['$scope', 'Geocode']
