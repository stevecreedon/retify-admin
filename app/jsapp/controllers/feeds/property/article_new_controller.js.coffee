window.FeedsPropertyArticleNewController = ($scope, PropertyArticle) ->
  $scope.groups = [
    { label: 'Terms and conditions', value: 'terms' },
    { label: 'Availabilities',       value: 'availability' }
  ]
  $scope.model = PropertyArticle.new( { property_id: $scope.feed.parent_id } )
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    $scope.process_saving($scope.form, $scope.model, { property_id: $scope.feed.parent_id })

  $scope.cancel = ->
    $scope.submited = false
    $scope.model    = PropertyArticle.new( { property_id: $scope.feed.parent_id } )

window.FeedsPropertyArticleNewController.$inject = ['$scope', 'PropertyArticle']
