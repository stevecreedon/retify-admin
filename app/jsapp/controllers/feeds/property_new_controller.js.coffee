window.FeedsPropertyNewController = ($scope, Property, Geocode) ->
  $scope.geocode = new Geocode()

  $scope.model = Property.new () ->
    if $scope.model.address
      if $scope.model.address.lat
        $scope.addresses = [ $scope.model.address ]
      else
        $scope.check_address()
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.model.address.lat
      $scope.process_saving($scope, {}, { message: 'Property was saved' } )
    else
      $scope.notify.alert text: 'Please enter correct address'

  $scope.cancel = ->
    $scope.submited = false
    $scope.model         = Property.new()

  $scope.check_address = ->
    $scope.geocode.find_with_timeout $scope.model.address, 1500, (address) ->
      $scope.$apply ->
        $scope.addresses = [ address ]
        angular.extend $scope.model.address, address
    , (addresses) ->
      $scope.$apply ->
        $scope.addresses = addresses

window.FeedsPropertyNewController.$inject = ['$scope', 'Property', 'Geocode']
