window.FeedsPropertyDirectionNewController = ($scope, PropertyDirection) ->
  $scope.groups = [
    'By foot',
    'By car',
    'By bus',
    'By train',
    'By plane'
  ]
  $scope.model = PropertyDirection.new( { property_id: $scope.feed.parent_id } )
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    $scope.process_saving($scope.form, $scope.model, { property_id: $scope.feed.parent_id })

  $scope.cancel = ->
    $scope.submited = false
    $scope.model    = PropertyDirection.new( { property_id: $scope.feed.parent_id } )

window.FeedsPropertyDirectionNewController.$inject = ['$scope', 'PropertyDirection']
