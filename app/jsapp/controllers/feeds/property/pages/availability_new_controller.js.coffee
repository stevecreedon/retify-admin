window.FeedsPropertyPagesAvailabilityNewController = ($scope, PropertyArticle) ->
  $scope.model = PropertyArticle.new( { property_id: $scope.feed.parent_id } )
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    $scope.model.group = 'availability'
    $scope.process_saving($scope, { property_id: $scope.feed.parent_id }, { message: 'Availability Page was saved' } )

  $scope.cancel = ->
    $scope.submited = false
    $scope.model    = PropertyArticle.new( { property_id: $scope.feed.parent_id } )

window.FeedsPropertyPagesAvailabilityNewController.$inject = ['$scope', 'PropertyArticle']
