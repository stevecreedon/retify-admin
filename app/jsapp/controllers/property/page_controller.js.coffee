window.PropertyPageController = ($scope, PropertyArticle) ->
  $scope.save = () ->
    if $scope.is_changed()
      new PropertyArticle($scope.page).$update ( (resource, headers) ->
        $scope.page        = angular.copy resource
        $scope.page_cached = angular.copy resource
      ), $scope.process_error_response

  $scope.reset = () ->
    $scope.page.title       = $scope.page_cached.title
    $scope.page.description = $scope.page_cached.description

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.page.title       != $scope.page_cached.title       ||
    $scope.page.description != $scope.page_cached.description

window.PropertyPageController.$inject = ['$scope', 'PropertyArticle']
