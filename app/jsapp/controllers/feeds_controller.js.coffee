window.FeedsController = ($scope, Feed) ->
  $scope.update_feeds = ->
    $scope.block()
    $scope.feeds = Feed.query ->
      $scope.unblock()

  $scope.process_saving = (scope, params, options) ->
    if scope.form.$valid
      $scope.block()
      success = (response, header) ->
        scope.model = angular.copy response
        $scope.update_feeds()
        options['success']() if options['success']
        $scope.notify.success text: options['message'] if options['message']
        $scope.unblock()
      if scope.model.id
        scope.model.$update params, success
      else
        scope.model.$save   params, success
      return true
    return false

  $scope.set_body_class 'feeds'
  $scope.update_feeds()

window.FeedsController.$inject = ['$scope', 'Feed']
