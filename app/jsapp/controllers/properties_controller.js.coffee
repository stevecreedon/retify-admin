window.PropertiesController = ($scope, Property) ->
  $scope.block()
  $scope.properties = Property.query () ->
    $scope.unblock()
    

  $scope.set_body_class 'properties'

window.PropertiesController.$inject = ['$scope', 'Property']
