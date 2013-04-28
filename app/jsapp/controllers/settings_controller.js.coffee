window.SettingsController = ($scope, Site) ->
  $scope.sites = Site.query ->
    $scope.site        = angular.copy $scope.sites[0]
    $scope.site_cached = angular.copy $scope.sites[0]

  $scope.set_body_class   'properties'
  $scope.submited       = false

  $scope.save = () ->
    $scope.submited     = true
    if $scope.form.$valid
      $scope.site_cached = angular.copy $scope.site
      $scope.site_cached.$update (->), $scope.process_error_response

  $scope.cancel = ->
    $scope.submited = false
    $scope.site     = angular.copy $scope.site_cached

window.SettingsController.$inject = ['$scope', 'Site']
