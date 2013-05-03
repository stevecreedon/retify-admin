window.FeedsController = ($scope, Feed) ->
  $scope.update_feeds = ->
    $scope.feeds = Feed.query()

  $scope.process_saving = (scope, params, options) ->
    if scope.form.$valid
      success = (response, header) ->
        scope.model = angular.copy response
        $scope.update_feeds()
        $scope.notify text: options['message'] if options['message']
      if scope.model.id
        scope.model.$update params, success, $scope.process_error_response
      else
        scope.model.$save   params, success, $scope.process_error_response
      return true
    return false

  $scope.set_body_class 'feeds'
  $scope.update_feeds()

window.FeedsController.$inject = ['$scope', 'Feed']
