window.SettingsController = ($scope, Site, Geocode) ->
  $scope.block()
  $scope.geocode  = new Geocode()

  $scope.sites = Site.query ->
    if $scope.sites.length == 0
      $scope.site        = Site.new ()->
        $scope.unblock()
        $scope.site_cached = angular.copy $scope.site
    else
      $scope.unblock()
      $scope.site          = angular.copy $scope.sites[0]
      $scope.site_cached   = angular.copy $scope.sites[0]
      $scope.addresses = [$scope.site.address]
      $scope.check_address() if $scope.site.address && !$scope.site.address.lat


  $scope.set_body_class   'properties'
  $scope.submited       = false

  $scope.check_address = ->
    $scope.geocode.find_with_timeout $scope.site.address, 1500, (address) ->
      $scope.$apply ->
        $scope.addresses = [ address ]
        angular.extend $scope.site.address, address
    , (addresses) ->
      $scope.$apply ->
        $scope.addresses = addresses

  $scope.save = () ->
    $scope.submited     = true
    if $scope.form.$valid && $scope.site.address.lat
      $scope.block()
      success = (model, headers)->
        $scope.site                   = angular.copy model
        $scope.site_cached            = angular.copy model
        $scope.current_site.subdomain = $scope.site.subdomain
        $scope.notify.success text: 'Settings saved'
        $scope.unblock()
      if $scope.site.id
        $scope.site.$update success
      else
        $scope.site.$save success
    else
      $scope.notify.alert text: 'Please enter correct address' unless $scope.site.address.lat

  $scope.cancel = ->
    $scope.submited = false
    $scope.site = angular.copy $scope.site_cached

window.SettingsController.$inject = ['$scope', 'Site', 'Geocode']
