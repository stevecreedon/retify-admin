window.SettingsController = ($scope, Site) ->
  $scope.sites = Site.query ->
    $scope.site        = angular.copy $scope.sites[0]
    $scope.site_cached = angular.copy $scope.sites[0]

  $scope.set_body_class   'properties'
  $scope.submited       = false

  $scope.save = () ->
    $scope.submited     = true
    if $scope.form.$valid
      $scope.site.$update (->
        $scope.site_cached = angular.copy $scope.site
        $scope.notify
          text: 'Settings saved'
      ), $scope.process_error_response

  $scope.cancel = ->
    $scope.submited = false
    $scope.site = angular.copy $scope.site_cached

  $scope.hey = ->
    console.log $scope.site

window.SettingsController.$inject = ['$scope', 'Site']
