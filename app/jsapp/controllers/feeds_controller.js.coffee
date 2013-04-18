window.FeedsController = ['$scope', '$location', 'Feed', ($scope, $location, Feed) ->
  $scope.update_feeds = ->
    $scope.feeds = Feed.query()

  $scope.process_saving = (form, model, params) ->
    if form.$valid
      model.$save params, $scope.update_feeds, $scope.process_error_response
      return true
    return false

  $scope.process_error_response = (response) ->
    switch response.status
      when 400
        $scope.server_errors = response.data.errors.full_messages
      when 404
        $location.path('/server_page_not_found')
      else
        $location.path('/server_error')

  $scope.update_feeds()
]
