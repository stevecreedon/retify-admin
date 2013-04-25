window.FeedsPropertyDirectionNewController = ($scope, PropertyDirection) ->
  $scope.directions = PropertyDirection.new { property_id: $scope.feed.parent_id }
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    for model in $scope.directions
      if model.description && model.description.length > 0
        $scope.process_saving($scope.form, model, { property_id: $scope.feed.parent_id })

  $scope.cancel = ->
    $scope.submited = false
    $scope.directions    = PropertyDirection.new( { property_id: $scope.feed.parent_id } )

window.FeedsPropertyDirectionNewController.$inject = ['$scope', 'PropertyDirection']
