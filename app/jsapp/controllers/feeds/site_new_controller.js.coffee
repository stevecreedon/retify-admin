window.FeedsSiteNewController = ($scope, Site) ->
  $scope.model    = Site.new()
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    $scope.process_saving($scope, {},
      message: 'Site was saved'
      success: ->
        $scope.current_site.subdomain = $scope.model.subdomain
    )

  $scope.cancel = ->
    $scope.submited = false
    $scope.model    = Site.new()

window.FeedsSiteNewController.$inject = ['$scope', 'Site']
