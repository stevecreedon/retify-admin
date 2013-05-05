window.PropertyPageController = ($scope, PropertyArticle) ->
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    if $scope.form.$valid && $scope.is_changed()
      new PropertyArticle($scope.page).$update (resource, headers) ->
        $scope.page        = angular.copy resource
        $scope.page_cached.title       = $scope.page.title
        $scope.page_cached.description = $scope.page.description
        $scope.notify.success text: 'Page was saved'

  $scope.reset = () ->
    $scope.submited = false
    $scope.page.title       = $scope.page_cached.title
    $scope.page.description = $scope.page_cached.description

  $scope.cancel = () ->
    $scope.reset()
    $scope.show('property', 'home')

  $scope.is_changed = () ->
    $scope.page.title       != $scope.page_cached.title       ||
    $scope.page.description != $scope.page_cached.description

window.PropertyPageController.$inject = ['$scope', 'PropertyArticle']
