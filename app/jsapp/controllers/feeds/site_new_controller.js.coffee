window.FeedsSiteNewController = ($scope, Site, Geocode) ->
  $scope.geocode  = new Geocode()

  $scope.model    = Site.new ()->
    $scope.check_address() unless $scope.model.address.lat

  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.model.address.lat
      $scope.process_saving($scope, {},
        message: 'Site was saved'
        success: ->
          $scope.current_site.subdomain = $scope.model.subdomain
      )
    else
      $scope.notify.alert text: 'Please enter correct address'

  $scope.cancel = ->
    $scope.submited = false
    $scope.model    = Site.new()

  $scope.check_address = ->
    $scope.geocode.find_with_timeout $scope.model.address, 1500, (address) ->
      $scope.$apply ->
        $scope.addresses = [ address ]
        angular.extend $scope.model.address, address
    , (addresses) ->
      $scope.$apply ->
        $scope.addresses = addresses

window.FeedsSiteNewController.$inject = ['$scope', 'Site', 'Geocode']
