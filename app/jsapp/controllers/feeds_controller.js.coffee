window.FeedsController = ($scope, Feed) ->
  $scope.update_feeds = ->
    $scope.feeds = Feed.query()

  $scope.process_saving = (scope, params) ->
    if scope.form.$valid
      if scope.model.id
        scope.model.$update params, ( (response, header) ->
          scope.model = angular.copy response
          $scope.update_feeds()
          $scope.notify
            text: 'Updated'
        ), $scope.process_error_response
      else
        scope.model.$save   params, ( (response, header) ->
          scope.model = angular.copy response
          $scope.update_feeds()
          $scope.notify
            text: 'Created'
        ), $scope.process_error_response
      return true
    return false

  $scope.set_body_class 'feeds'
  $scope.update_feeds()

window.FeedsController.$inject = ['$scope', 'Feed']
