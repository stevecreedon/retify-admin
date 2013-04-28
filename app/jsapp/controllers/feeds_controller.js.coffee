window.FeedsController = ($scope, Feed) ->
  $scope.update_feeds = ->
    $scope.feeds = Feed.query()

  $scope.process_saving = (form, model, params) ->
    if form.$valid
      if model.id
        model.$update params, $scope.update_feeds, $scope.process_error_response
      else
        model.$save   params, $scope.update_feeds, $scope.process_error_response
      return true
    return false

  $scope.set_body_class 'feeds'
  $scope.update_feeds()

window.FeedsController.$inject = ['$scope', 'Feed']
