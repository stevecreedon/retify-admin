window.PropertyPageNewController = ($scope, PropertyArticle) ->
  $scope.groups = []

  if $scope.property.articles.length == 0
    $scope.page = new PropertyArticle({ source_id : $scope.property.id, source_type: 'property' })
    $scope.groups.push({ label: 'Availability Page',           value: 'availability' })
    $scope.groups.push({ label: 'Terms and Conditions Page',   value: 'terms' })
  else if $scope.property.articles.length == 1
    if $scope.property.articles[0].group == 'terms'
      $scope.page = new PropertyArticle({ source_id : $scope.property.id, source_type: 'property', group: 'availability' })
      $scope.groups.push({ label: 'Availability Page',         value: 'availability' })
    else if $scope.property.articles[0].group == 'availability'
      $scope.page = new PropertyArticle({ source_id : $scope.property.id, source_type: 'property', group: 'terms' })
      $scope.groups.push({ label: 'Terms and Conditions Page', value: 'terms' })


  $scope.save = () ->
    $scope.submited = true
    $scope.page.$save ( (resource, headers)->
      $scope.page = resource
      $scope.property_cached.articles.push($scope.page)
      $scope.property.articles = angular.copy $scope.property_cached.articles
      $scope.show('pages', $scope.page.title)
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

window.PropertyPageNewController.$inject = ['$scope', 'PropertyArticle']
