window.SettingsController = ($scope, Site) ->
  $scope.block()
  $scope.sites = Site.query ->
    if $scope.sites.length == 0
      $.blockUI message: 'Loading ...'
      $scope.site        = Site.new ()->
        $scope.unblock()
        $scope.site_cached = angular.copy $scope.site
    else
      $scope.unblock()
      $scope.site          = angular.copy $scope.sites[0]
      $scope.site_cached   = angular.copy $scope.sites[0]

  $scope.set_body_class   'properties'
  $scope.submited       = false

  $scope.save = () ->
    $scope.submited     = true
    if $scope.form.$valid
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

  $scope.cancel = ->
    $scope.submited = false
    $scope.site = angular.copy $scope.site_cached

window.SettingsController.$inject = ['$scope', 'Site']
