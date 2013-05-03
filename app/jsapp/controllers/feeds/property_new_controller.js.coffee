window.FeedsPropertyNewController = ($scope, Property) ->
  $scope.model = Property.new()
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    $scope.process_saving($scope, {}, { message: 'Property was saved' } )

  $scope.cancel = ->
    $scope.submited = false
    $scope.model         = Property.new()

window.FeedsPropertyNewController.$inject = ['$scope', 'Property']
