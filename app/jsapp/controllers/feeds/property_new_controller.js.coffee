window.FeedsPropertyNewController = ($scope, Property) ->
  $scope.model = Property.new()
  $scope.submited = false

  $scope.save = () ->
    $scope.submited = true
    $scope.process_saving($scope.form, $scope.model, {})

  $scope.cancel = ->
    $scope.submited = false
    $scope.model         = Property.new()

window.FeedsPropertyNewController.$inject = ['$scope', 'Property']
