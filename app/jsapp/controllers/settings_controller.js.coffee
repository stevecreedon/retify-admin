window.SettingsController = ($scope, Site) ->
  $scope.sites = Site.query ->
    if $scope.sites.length == 0
      $scope.site        = Site.new ()->
        $scope.site_cached = angular.copy $scope.site
    else
      $scope.site          = angular.copy $scope.sites[0]
      $scope.site_cached   = angular.copy $scope.sites[0]

  $scope.set_body_class   'properties'
  $scope.submited       = false

  $scope.save = () ->
    $scope.submited     = true
    if $scope.form.$valid
      success = (model, headers)->
        $scope.site                   = angular.copy model
        $scope.site_cached            = angular.copy model
        $scope.current_site.subdomain = $scope.site.subdomain
        $scope.notify.success text: 'Settings saved'
      if $scope.site.id
        $scope.site.$update success, $scope.process_error_response
      else
        $scope.site.$save success, $scope.process_error_response

  $scope.cancel = ->
    $scope.submited = false
    $scope.site = angular.copy $scope.site_cached

  $scope.hey = ->
    console.log $scope.site

window.SettingsController.$inject = ['$scope', 'Site']
